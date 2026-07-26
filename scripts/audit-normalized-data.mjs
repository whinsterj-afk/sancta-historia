import { createClient } from "@supabase/supabase-js";

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseAnonKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseAnonKey) {
  console.error(
    "Missing NEXT_PUBLIC_SUPABASE_URL or NEXT_PUBLIC_SUPABASE_ANON_KEY.",
  );
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseAnonKey, {
  auth: {
    autoRefreshToken: false,
    detectSessionInUrl: false,
    persistSession: false,
  },
});

function normalize(value) {
  return String(value ?? "")
    .normalize("NFD")
    .replace(/\p{Diacritic}/gu, "")
    .toLocaleLowerCase("pt-BR")
    .replace(/[^\p{Letter}\p{Number}]+/gu, " ")
    .trim();
}

function groupBy(values, getKey) {
  const groups = new Map();
  for (const value of values) {
    const key = getKey(value);
    const group = groups.get(key) ?? [];
    group.push(value);
    groups.set(key, group);
  }
  return groups;
}

function hasValidCoordinates({ latitude, longitude }) {
  if (latitude == null || longitude == null) return false;

  const numericLatitude = Number(latitude);
  const numericLongitude = Number(longitude);
  return (
    Number.isFinite(numericLatitude) &&
    Number.isFinite(numericLongitude) &&
    numericLatitude >= -90 &&
    numericLatitude <= 90 &&
    numericLongitude >= -180 &&
    numericLongitude <= 180
  );
}

const [
  saintsResult,
  trajectoryResult,
  heritageResult,
  placesResult,
  aliasesResult,
  searchResult,
] = await Promise.all([
  supabase.from("saints_catalog").select("*").order("id"),
  supabase
    .from("timeline_saint_points")
    .select("*")
    .order("saint_id")
    .order("sequence_order")
    .order("id"),
  supabase
    .from("saint_heritage_points")
    .select("*")
    .order("saint_id")
    .order("sequence_order")
    .order("id"),
  supabase.from("places").select("*").order("id"),
  supabase.from("saint_aliases").select("*").order("saint_id").order("id"),
  supabase.from("saint_search_catalog").select("*").order("id"),
]);

for (const result of [
  saintsResult,
  trajectoryResult,
  heritageResult,
  placesResult,
  aliasesResult,
  searchResult,
]) {
  if (result.error) throw result.error;
}

const saints = saintsResult.data ?? [];
const trajectoryPoints = trajectoryResult.data ?? [];
const heritagePoints = heritageResult.data ?? [];
const places = placesResult.data ?? [];
const aliases = aliasesResult.data ?? [];
const searchEntries = searchResult.data ?? [];

const saintsById = new Map(saints.map((saint) => [saint.id, saint]));
const pointsBySaint = groupBy(
  trajectoryPoints,
  (trajectoryPoint) => trajectoryPoint.saint_id,
);
const searchBySaint = new Map(
  searchEntries.map((entry) => [entry.id, entry.search_text]),
);

const invalidCoordinates = [...trajectoryPoints, ...heritagePoints].filter(
  (point) => !hasValidCoordinates(point),
);
const orphanTrajectoryPoints = trajectoryPoints.filter(
  (point) => !saintsById.has(point.saint_id),
);
const lifePointsOutsideLifetime = trajectoryPoints.filter((point) => {
  const saint = saintsById.get(point.saint_id);
  if (!saint) return false;

  return (
    (point.start_year != null &&
      saint.birth_year != null &&
      point.start_year < saint.birth_year) ||
    (point.end_year != null &&
      saint.death_year != null &&
      point.end_year > saint.death_year) ||
    (point.start_year != null &&
      point.end_year != null &&
      point.start_year > point.end_year)
  );
});
const duplicateTrajectoryGroups = [
  ...groupBy(trajectoryPoints, (point) =>
    [
      point.saint_id,
      normalize(point.location_name),
      point.start_year,
      point.end_year,
    ].join("|"),
  ).values(),
].filter((group) => group.length > 1);
const duplicateSequenceGroups = [
  ...groupBy(
    trajectoryPoints,
    (point) => `${point.saint_id}|${point.sequence_order}`,
  ).values(),
].filter((group) => group.length > 1);
const aliasesMissingFromSearch = aliases.filter((alias) => {
  const searchText = searchBySaint.get(alias.saint_id);
  return !searchText || !searchText.includes(alias.normalized_alias);
});
const saintsWithoutTrajectory = saints
  .filter((saint) => !(pointsBySaint.get(saint.id) ?? []).length)
  .map(({ id, name }) => ({ id, name }));

const integrity = {
  validCoordinates: invalidCoordinates.length === 0,
  noOrphanTrajectoryPoints: orphanTrajectoryPoints.length === 0,
  lifePeriodsInsideLifetime: lifePointsOutsideLifetime.length === 0,
  noDuplicateTrajectories: duplicateTrajectoryGroups.length === 0,
  uniqueSequencePerSaint: duplicateSequenceGroups.length === 0,
  aliasesIncludedInSearch: aliasesMissingFromSearch.length === 0,
};

const saintIdsArgument = process.argv.find((argument) =>
  argument.startsWith("--saint-ids="),
);
const selectedSaintIds = saintIdsArgument
  ? new Set(
      saintIdsArgument
        .slice("--saint-ids=".length)
        .split(",")
        .map(Number)
        .filter(Number.isInteger),
    )
  : null;

const output = selectedSaintIds
  ? saints
      .filter((saint) => selectedSaintIds.has(saint.id))
      .map((saint) => ({
        id: saint.id,
        name: saint.name,
        aliases: aliases
          .filter((alias) => alias.saint_id === saint.id)
          .map((alias) => alias.alias),
        trajectory: pointsBySaint.get(saint.id) ?? [],
        heritage: heritagePoints.filter((point) => point.saint_id === saint.id),
      }))
  : {
      totals: {
        canonicalSaints: saints.length,
        canonicalPlaces: places.length,
        lifeTrajectoryPoints: trajectoryPoints.length,
        heritagePoints: heritagePoints.length,
        saintAliases: aliases.length,
      },
      integrity,
      issues: {
        invalidCoordinates,
        orphanTrajectoryPoints,
        lifePointsOutsideLifetime,
        duplicateTrajectoryGroups,
        duplicateSequenceGroups,
        aliasesMissingFromSearch,
      },
      coverage: {
        saintsWithTrajectory: saints.length - saintsWithoutTrajectory.length,
        saintsWithoutTrajectory,
      },
    };

console.log(JSON.stringify(output, null, 2));

if (!Object.values(integrity).every(Boolean)) {
  process.exitCode = 1;
}
