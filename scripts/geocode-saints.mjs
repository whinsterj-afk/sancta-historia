// One-off script: fills birth_lat/birth_lng/death_lat/death_lng on the saints
// table by geocoding birth_place/death_place through the MapTiler Geocoding API.
//
// Usage: node --env-file=.env.local scripts/geocode-saints.mjs

const SUPABASE_URL = process.env.NEXT_PUBLIC_SUPABASE_URL;
const SERVICE_ROLE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY;
const MAPTILER_KEY = process.env.NEXT_PUBLIC_MAPTILER_KEY;

if (!SUPABASE_URL || !SERVICE_ROLE_KEY || !MAPTILER_KEY) {
  console.error("Missing NEXT_PUBLIC_SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY or NEXT_PUBLIC_MAPTILER_KEY.");
  process.exit(1);
}

const sleep = (ms) => new Promise((resolve) => setTimeout(resolve, ms));

async function fetchSaints() {
  const res = await fetch(
    `${SUPABASE_URL}/rest/v1/saints?select=id,name,birth_place,death_place,birth_lat,birth_lng,death_lat,death_lng`,
    {
      headers: {
        apikey: SERVICE_ROLE_KEY,
        Authorization: `Bearer ${SERVICE_ROLE_KEY}`,
      },
    }
  );
  if (!res.ok) throw new Error(`Failed to fetch saints: ${res.status} ${await res.text()}`);
  return res.json();
}

async function updateSaint(id, fields) {
  const res = await fetch(`${SUPABASE_URL}/rest/v1/saints?id=eq.${id}`, {
    method: "PATCH",
    headers: {
      apikey: SERVICE_ROLE_KEY,
      Authorization: `Bearer ${SERVICE_ROLE_KEY}`,
      "Content-Type": "application/json",
      Prefer: "return=minimal",
    },
    body: JSON.stringify(fields),
  });
  if (!res.ok) throw new Error(`Failed to update saint ${id}: ${res.status} ${await res.text()}`);
}

const placeCache = new Map();

async function geocode(place) {
  if (!place) return null;
  if (placeCache.has(place)) return placeCache.get(place);

  const url = `https://api.maptiler.com/geocoding/${encodeURIComponent(place)}.json?key=${MAPTILER_KEY}&limit=1`;
  const res = await fetch(url);
  if (!res.ok) {
    console.warn(`  geocoding failed for "${place}": ${res.status}`);
    placeCache.set(place, null);
    return null;
  }

  const data = await res.json();
  const feature = data.features?.[0];
  const coords = feature ? { lng: feature.center[0], lat: feature.center[1] } : null;

  if (!coords) console.warn(`  no match for "${place}"`);
  placeCache.set(place, coords);
  return coords;
}

async function main() {
  const saints = await fetchSaints();
  console.log(`Loaded ${saints.length} saints.`);

  let updated = 0;
  for (const saint of saints) {
    const needsBirth = saint.birth_place && (saint.birth_lat == null || saint.birth_lng == null);
    const needsDeath = saint.death_place && (saint.death_lat == null || saint.death_lng == null);

    if (!needsBirth && !needsDeath) continue;

    console.log(`Geocoding "${saint.name}"...`);
    const fields = {};

    if (needsBirth) {
      const coords = await geocode(saint.birth_place);
      await sleep(150);
      if (coords) {
        fields.birth_lat = coords.lat;
        fields.birth_lng = coords.lng;
      }
    }

    if (needsDeath) {
      const coords = await geocode(saint.death_place);
      await sleep(150);
      if (coords) {
        fields.death_lat = coords.lat;
        fields.death_lng = coords.lng;
      }
    }

    if (Object.keys(fields).length > 0) {
      await updateSaint(saint.id, fields);
      updated++;
    }
  }

  console.log(`Done. Updated ${updated} saint(s).`);
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
