import { supabase } from "@/lib/supabase";
import type {
  HistoricalEvent,
  Location,
  Pope,
  Saint,
  SiteStats,
  TimelineData,
  TimelineMapMode,
} from "@/lib/types";

export const DEFAULT_YEAR = 1220;
export const MIN_YEAR = 1;
export const MAX_YEAR = new Date().getFullYear();

export const SIGNIFICANT_YEARS = [
  33, 325, 800, 1095, 1220, 1517, 1545, 1962, 1978, 2005,
];

const saintCardColumns =
  "id, name, birth_year, death_year, birth_year_note, death_year_note, birth_place, death_place, short_description, category";

const saintDetailColumns =
  "id, name, birth_year, death_year, birth_year_note, death_year_note, birth_place, death_place, short_description, biography, feast_day, canonization_year, canonization_note, patron_of, image_url, religious_order, category, famous_quote, historical_importance, sources";

const popeColumns = "id, name, start_year, end_year, nationality, description";
const eventColumns = "id, title, year, category, description";
const locationColumns =
  "id, saint_id, location_name, latitude, longitude, start_year, end_year, description";
const locationWithSaintColumns = `${locationColumns}, saints(id, name)`;

type QueryResult<T> = {
  data: T | null;
  error: { message: string } | null;
};

function requireData<T>(result: QueryResult<T>, message: string) {
  if (result.error) {
    throw new Error(`${message}: ${result.error.message}`);
  }

  return result.data;
}

export function parsePositiveId(value: string) {
  if (!/^\d+$/.test(value)) {
    return null;
  }

  const id = Number(value);
  return Number.isSafeInteger(id) && id > 0 ? id : null;
}

export function parseYear(value: string | string[] | undefined) {
  const raw = Array.isArray(value) ? value[0] : value;
  const parsed = raw ? Number(raw) : DEFAULT_YEAR;

  if (!Number.isSafeInteger(parsed)) {
    return DEFAULT_YEAR;
  }

  return Math.min(Math.max(parsed, MIN_YEAR), MAX_YEAR);
}

export function parseTimelineMapMode(
  value: string | string[] | undefined
): TimelineMapMode {
  const raw = Array.isArray(value) ? value[0] : value;
  return raw === "journey" ? "journey" : "year";
}

export async function getSiteStats(): Promise<SiteStats> {
  const [saintsCount, popesCount, eventsCount, locationsCount] =
    await Promise.all([
      supabase.from("saints").select("id", { count: "exact", head: true }),
      supabase.from("popes").select("id", { count: "exact", head: true }),
      supabase
        .from("historical_events")
        .select("id", { count: "exact", head: true }),
      supabase.from("locations").select("id", { count: "exact", head: true }),
    ]);

  for (const result of [saintsCount, popesCount, eventsCount, locationsCount]) {
    if (result.error) {
      throw new Error(`Não foi possível carregar estatísticas: ${result.error.message}`);
    }
  }

  return {
    saints: saintsCount.count || 0,
    popes: popesCount.count || 0,
    events: eventsCount.count || 0,
    locations: locationsCount.count || 0,
  };
}

export async function getTimelineData(
  year: number,
  mapMode: TimelineMapMode
): Promise<TimelineData> {
  const [saintsResult, popesResult, eventsResult] = await Promise.all([
    supabase
      .from("saints")
      .select("id, name, birth_year, death_year, birth_year_note, death_year_note, short_description")
      .lte("birth_year", year)
      .gte("death_year", year)
      .order("birth_year"),
    supabase
      .from("popes")
      .select(popeColumns)
      .lte("start_year", year)
      .gte("end_year", year)
      .order("start_year"),
    supabase
      .from("historical_events")
      .select(eventColumns)
      .lte("year", year)
      .order("year", { ascending: false })
      .limit(8),
  ]);

  const saints = requireData<Saint[]>(
    saintsResult as QueryResult<Saint[]>,
    "Não foi possível carregar santos da linha do tempo"
  ) || [];
  const popes = requireData<Pope[]>(
    popesResult as QueryResult<Pope[]>,
    "Não foi possível carregar papas da linha do tempo"
  ) || [];
  const events = requireData<HistoricalEvent[]>(
    eventsResult as QueryResult<HistoricalEvent[]>,
    "Não foi possível carregar eventos da linha do tempo"
  ) || [];

  let locations: Location[] = [];

  if (mapMode === "year") {
    const result = await supabase
      .from("locations")
      .select(locationWithSaintColumns)
      .lte("start_year", year)
      .gte("end_year", year)
      .order("start_year");

    locations =
      requireData<Location[]>(
        result as QueryResult<Location[]>,
        "Não foi possível carregar locais do ano"
      ) || [];
  }

  if (mapMode === "journey" && saints.length > 0) {
    const result = await supabase
      .from("locations")
      .select(locationWithSaintColumns)
      .in(
        "saint_id",
        saints.map((saint) => saint.id)
      )
      .order("start_year");

    locations =
      requireData<Location[]>(
        result as QueryResult<Location[]>,
        "Não foi possível carregar trajetórias dos santos"
      ) || [];
  }

  return { saints, popes, events, locations };
}

export async function getSaintCategories() {
  const result = await supabase.from("saints").select("category").order("category");
  const rows =
    requireData<Array<{ category: string | null }>>(
      result as QueryResult<Array<{ category: string | null }>>,
      "Não foi possível carregar categorias"
    ) || [];

  return Array.from(
    new Set(rows.map((row) => row.category?.trim()).filter(Boolean) as string[])
  );
}

export async function getSaints({
  search,
  category,
  limit = 80,
}: {
  search?: string;
  category?: string;
  limit?: number;
}) {
  let query = supabase
    .from("saints")
    .select(saintCardColumns)
    .order("birth_year", { ascending: true })
    .limit(limit);

  if (search?.trim()) {
    query = query.ilike("name", `%${search.trim()}%`);
  }

  if (category?.trim()) {
    query = query.eq("category", category.trim());
  }

  return (
    requireData<Saint[]>(
      (await query) as QueryResult<Saint[]>,
      "Não foi possível carregar santos"
    ) || []
  );
}

export async function getSaintProfile(id: number) {
  const saintResult = await supabase
    .from("saints")
    .select(saintDetailColumns)
    .eq("id", id)
    .single();

  const saint = requireData<Saint>(
    saintResult as QueryResult<Saint>,
    "Não foi possível carregar o santo"
  );

  if (!saint) {
    return null;
  }

  const birthYear = saint.birth_year ?? MIN_YEAR;
  const deathYear = saint.death_year ?? MAX_YEAR;

  const [popesResult, eventsResult, contemporariesResult, locationsResult] =
    await Promise.all([
      supabase
        .from("popes")
        .select(popeColumns)
        .lte("start_year", deathYear)
        .gte("end_year", birthYear)
        .order("start_year"),
      supabase
        .from("historical_events")
        .select(eventColumns)
        .gte("year", birthYear)
        .lte("year", deathYear)
        .order("year"),
      supabase
        .from("saints")
        .select(saintCardColumns)
        .neq("id", saint.id)
        .lte("birth_year", deathYear)
        .gte("death_year", birthYear)
        .order("birth_year")
        .limit(12),
      supabase
        .from("locations")
        .select(locationColumns)
        .eq("saint_id", saint.id)
        .order("start_year"),
    ]);

  return {
    saint,
    popes:
      requireData<Pope[]>(
        popesResult as QueryResult<Pope[]>,
        "Não foi possível carregar papas contemporâneos"
      ) || [],
    events:
      requireData<HistoricalEvent[]>(
        eventsResult as QueryResult<HistoricalEvent[]>,
        "Não foi possível carregar eventos contemporâneos"
      ) || [],
    contemporaries:
      requireData<Saint[]>(
        contemporariesResult as QueryResult<Saint[]>,
        "Não foi possível carregar santos contemporâneos"
      ) || [],
    locations:
      requireData<Location[]>(
        locationsResult as QueryResult<Location[]>,
        "Não foi possível carregar locais relacionados"
      ) || [],
  };
}

export async function getPopes() {
  const result = await supabase
    .from("popes")
    .select(popeColumns)
    .order("start_year");

  return (
    requireData<Pope[]>(
      result as QueryResult<Pope[]>,
      "Não foi possível carregar papas"
    ) || []
  );
}

export async function getPopeProfile(id: number) {
  const popeResult = await supabase
    .from("popes")
    .select(popeColumns)
    .eq("id", id)
    .single();

  const pope = requireData<Pope>(
    popeResult as QueryResult<Pope>,
    "Não foi possível carregar o papa"
  );

  if (!pope) {
    return null;
  }

  const startYear = pope.start_year ?? MIN_YEAR;
  const endYear = pope.end_year ?? MAX_YEAR;

  const [saintsResult, eventsResult] = await Promise.all([
    supabase
      .from("saints")
      .select(saintCardColumns)
      .lte("birth_year", endYear)
      .gte("death_year", startYear)
      .order("birth_year")
      .limit(24),
    supabase
      .from("historical_events")
      .select(eventColumns)
      .gte("year", startYear)
      .lte("year", endYear)
      .order("year")
      .limit(24),
  ]);

  return {
    pope,
    saints:
      requireData<Saint[]>(
        saintsResult as QueryResult<Saint[]>,
        "Não foi possível carregar santos do pontificado"
      ) || [],
    events:
      requireData<HistoricalEvent[]>(
        eventsResult as QueryResult<HistoricalEvent[]>,
        "Não foi possível carregar eventos do pontificado"
      ) || [],
  };
}

export async function getHistoricalEvents(category?: string) {
  let query = supabase
    .from("historical_events")
    .select(eventColumns)
    .order("year", { ascending: true })
    .limit(120);

  if (category?.trim()) {
    query = query.eq("category", category.trim());
  }

  return (
    requireData<HistoricalEvent[]>(
      (await query) as QueryResult<HistoricalEvent[]>,
      "Não foi possível carregar eventos históricos"
    ) || []
  );
}

export async function getEventCategories() {
  const result = await supabase
    .from("historical_events")
    .select("category")
    .order("category");
  const rows =
    requireData<Array<{ category: string | null }>>(
      result as QueryResult<Array<{ category: string | null }>>,
      "Não foi possível carregar categorias de eventos"
    ) || [];

  return Array.from(
    new Set(rows.map((row) => row.category?.trim()).filter(Boolean) as string[])
  );
}

export async function getHistoricalEventProfile(id: number) {
  const eventResult = await supabase
    .from("historical_events")
    .select(eventColumns)
    .eq("id", id)
    .single();

  const event = requireData<HistoricalEvent>(
    eventResult as QueryResult<HistoricalEvent>,
    "Não foi possível carregar o evento histórico"
  );

  if (!event) {
    return null;
  }

  const year = event.year ?? DEFAULT_YEAR;
  const [popesResult, saintsResult] = await Promise.all([
    supabase
      .from("popes")
      .select(popeColumns)
      .lte("start_year", year)
      .gte("end_year", year)
      .order("start_year"),
    supabase
      .from("saints")
      .select(saintCardColumns)
      .lte("birth_year", year)
      .gte("death_year", year)
      .order("birth_year")
      .limit(24),
  ]);

  return {
    event,
    popes:
      requireData<Pope[]>(
        popesResult as QueryResult<Pope[]>,
        "Não foi possível carregar papas do ano"
      ) || [],
    saints:
      requireData<Saint[]>(
        saintsResult as QueryResult<Saint[]>,
        "Não foi possível carregar santos vivos no ano"
      ) || [],
  };
}

export async function getLocations() {
  const result = await supabase
    .from("locations")
    .select(locationWithSaintColumns)
    .order("location_name")
    .limit(160);

  return (
    requireData<Location[]>(
      result as QueryResult<Location[]>,
      "Não foi possível carregar locais"
    ) || []
  );
}

export async function getLocationProfile(id: number) {
  const locationResult = await supabase
    .from("locations")
    .select(locationWithSaintColumns)
    .eq("id", id)
    .single();

  const location = requireData<Location>(
    locationResult as QueryResult<Location>,
    "Não foi possível carregar o local"
  );

  if (!location) {
    return null;
  }

  const relatedResult = location.saint_id
    ? await supabase
        .from("locations")
        .select(locationWithSaintColumns)
        .eq("saint_id", location.saint_id)
        .neq("id", location.id)
        .order("start_year")
    : null;

  return {
    location,
    relatedLocations: relatedResult
      ? requireData<Location[]>(
          relatedResult as QueryResult<Location[]>,
          "Não foi possível carregar locais relacionados"
        ) || []
      : [],
  };
}
