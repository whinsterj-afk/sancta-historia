import { mkdir, writeFile } from "node:fs/promises";
import { dirname, resolve } from "node:path";

const ENDPOINT = "https://query.wikidata.org/sparql";
const USER_AGENT =
  "SanctaHistoriaResearch/1.0 (https://sanctahistoria.com/)";

const TYPE_BY_QID = {
  Q105390172: {
    canonicalType: "metropolitan_archdiocese",
    tradition: "latin",
  },
  Q105419665: {
    canonicalType: "archdiocese",
    tradition: "latin",
  },
  Q105072162: {
    canonicalType: "archdiocese",
    tradition: "latin",
  },
  Q104964763: {
    canonicalType: "archdiocese",
    tradition: "latin",
  },
  Q105072138: {
    canonicalType: "archdiocese",
    tradition: "latin",
  },
  Q105406193: {
    canonicalType: "archdiocese",
    tradition: "latin",
  },
  Q108822885: {
    canonicalType: "metropolitan_archeparchy",
    tradition: "eastern",
  },
  Q108822950: {
    canonicalType: "archeparchy",
    tradition: "eastern",
  },
  Q2072238: {
    canonicalType: "metropolitan_archdiocese",
    tradition: "latin",
  },
  Q12593969: {
    canonicalType: "patriarchate",
    tradition: "latin",
  },
};

const CONTINENT_BY_QID = {
  Q15: "africa",
  Q46: "europe",
  Q48: "asia",
  Q49: "americas",
  Q18: "americas",
  Q538: "oceania",
  Q55643: "oceania",
};

const RECORD_OVERRIDES = {
  Q254246: {
    name: "Arquidiocese de Santiago del Estero",
    canonicalType: "archdiocese",
    verifiedErectedYear: 2024,
    verificationUrl:
      "https://press.vatican.va/content/salastampa/en/bollettino/pubblico/2024/07/22/240722a.html",
    verificationTitle:
      "Boletim da Santa Sé — elevação de Santiago del Estero a arquidiocese",
  },
  Q530906: {
    name: "Patriarcado Latino de Jerusalém",
    countryCode: "PS",
    continent: "asia",
  },
  Q740783: {
    name: "Patriarcado de Veneza",
  },
  Q1110488: {
    name: "Patriarcado de Lisboa",
  },
  Q261532: {
    name: "Arquieparquia Metropolitana de São João Batista em Curitiba dos Ucranianos",
  },
  Q261716: {
    countryCode: "NL",
    continent: "europe",
  },
  Q420393: {
    name: "Arquieparquia Maior de Ernakulam-Angamaly",
    canonicalType: "metropolitan_archeparchy",
    tradition: "eastern",
  },
  Q420451: {
    name: "Arquieparquia Metropolitana de Ujjain",
    canonicalType: "metropolitan_archeparchy",
    latitude: 23.182777777,
    longitude: 75.777222222,
    coordinateSource: "city",
    verifiedErectedYear: 2025,
    verificationUrl:
      "https://press.vatican.va/content/salastampa/en/bollettino/pubblico/2025/08/28/250828d.html",
    verificationTitle:
      "Boletim da Santa Sé — províncias metropolitanas siro-malabares de 2025",
  },
  Q420476: {
    name: "Arquieparquia Metropolitana de Faridabad",
    canonicalType: "metropolitan_archeparchy",
    verifiedErectedYear: 2025,
    verificationUrl:
      "https://press.vatican.va/content/salastampa/en/bollettino/pubblico/2025/08/28/250828d.html",
    verificationTitle:
      "Boletim da Santa Sé — províncias metropolitanas siro-malabares de 2025",
  },
  Q582915: {
    name: "Arquidiocese Metropolitana de Joinville",
    verifiedErectedYear: 2024,
    verificationUrl:
      "https://press.vatican.va/content/salastampa/en/bollettino/pubblico/2024/11/05/241105b.html",
    verificationTitle:
      "Boletim da Santa Sé — províncias eclesiásticas de Joinville e Chapecó",
  },
  Q739626: {
    existingJurisdictionSlug: "arquidiocese-brasilia",
    existingSiteSlug: "catedral-metropolitana-brasilia",
  },
  Q867116: {
    name: "Arquidiocese Metropolitana de Berbérati",
    canonicalType: "metropolitan_archdiocese",
    verifiedErectedYear: 2026,
    verificationUrl:
      "https://press.vatican.va/content/salastampa/en/bollettino/pubblico/2026/04/25/260425b.html",
    verificationTitle:
      "Boletim da Santa Sé — ereção da província eclesiástica de Berbérati",
  },
  Q867555: {
    name: "Arquidiocese Metropolitana de Calicut",
    verifiedErectedYear: 2025,
    verificationUrl:
      "https://press.vatican.va/content/salastampa/en/bollettino/pubblico/2025/04/12/250412b.html",
    verificationTitle:
      "Boletim da Santa Sé — ereção da província eclesiástica de Calicut",
  },
  Q867802: {
    name: "Arquidiocese Metropolitana de Chapecó",
    verifiedErectedYear: 2024,
    verificationUrl:
      "https://press.vatican.va/content/salastampa/en/bollettino/pubblico/2024/11/05/241105b.html",
    verificationTitle:
      "Boletim da Santa Sé — províncias eclesiásticas de Joinville e Chapecó",
  },
  Q870248: {
    name: "Arquieparquia Metropolitana de Kalyan",
    canonicalType: "metropolitan_archeparchy",
    verifiedErectedYear: 2025,
    verificationUrl:
      "https://press.vatican.va/content/salastampa/en/bollettino/pubblico/2025/08/28/250828d.html",
    verificationTitle:
      "Boletim da Santa Sé — províncias metropolitanas siro-malabares de 2025",
  },
  Q876940: {
    name: "Arquidiocese Metropolitana de São José do Rio Preto",
    verifiedErectedYear: 2025,
    verificationUrl:
      "https://press.vatican.va/content/salastampa/en/bollettino/pubblico/2025/05/22/250522b.html",
    verificationTitle:
      "Boletim da Santa Sé — província eclesiástica de São José do Rio Preto",
  },
  Q1365956: {
    name: "Arquieparquia Greco-Melquita Católica de Baalbek",
  },
  Q41793077: {
    name: "Arquieparquia Metropolitana de Shamshabad",
    canonicalType: "metropolitan_archeparchy",
    latitude: 17.2603,
    longitude: 78.3969,
    coordinateSource: "city",
    verifiedErectedYear: 2025,
    verificationUrl:
      "https://press.vatican.va/content/salastampa/en/bollettino/pubblico/2025/08/28/250828d.html",
    verificationTitle:
      "Boletim da Santa Sé — províncias metropolitanas siro-malabares de 2025",
  },
  Q66829662: {
    name: "Arquieparquia Siríaca Católica de Hadiab-Erbil",
  },
};

// Ndola still carries only Wikidata's generic Catholic-diocese class. Keep the
// current archdiocese as an explicit, traceable supplement until that item is
// classified as an archdiocese in the structured source.
const SUPPLEMENTAL_RECORDS = [
  {
    qid: "Q872957",
    wikidataUrl: "https://www.wikidata.org/wiki/Q872957",
    name: "Arquidiocese Metropolitana de Ndola",
    canonicalType: "metropolitan_archdiocese",
    tradition: "latin",
    countryCode: "ZM",
    continent: "africa",
    latitude: -12.969111,
    longitude: 28.639667,
    coordinateSource: "jurisdiction",
    officialUrl: "https://www.ndoladiocese.org/",
    erectedYear: 1938,
    catholicHierarchyId: "ndol",
    gCatholicId: "ndol0",
    verifiedErectedYear: 2024,
    verificationUrl:
      "https://press.vatican.va/content/salastampa/en/bollettino/pubblico/2024/06/18/240618a.html",
    verificationTitle:
      "Boletim da Santa Sé — ereção da província eclesiástica de Ndola",
  },
];

const QUERY = `
SELECT
  ?item
  ?type
  ?itemLabel
  ?countryCode
  ?continent
  ?directCoord
  ?headquartersCoord
  ?officialUrl
  ?inception
  ?catholicHierarchyId
  ?gCatholicId
WHERE {
  {
    VALUES ?type {
      wd:Q105390172
      wd:Q105419665
      wd:Q105072162
      wd:Q104964763
      wd:Q105072138
      wd:Q105406193
      wd:Q108822885
      wd:Q108822950
      wd:Q12593969
    }
    ?item wdt:P31 ?type .
  }
  UNION
  {
    # Some current Catholic archdioceses still use only Wikidata's generic
    # archdiocese class. Two independent Catholic directory identifiers
    # separate them from Orthodox/Anglican entities using the same class.
    ?item wdt:P31 wd:Q2072238 ;
          wdt:P1866 ?requiredCatholicHierarchyId ;
          wdt:P8389 ?requiredGCatholicId .
    BIND(wd:Q2072238 AS ?type)
  }

  FILTER NOT EXISTS { ?item wdt:P576 ?dissolved . }
  FILTER NOT EXISTS { ?item wdt:P31 wd:Q27780831 . }
  FILTER NOT EXISTS { ?item wdt:P31 wd:Q15217609 . }
  FILTER NOT EXISTS { ?item wdt:P31 wd:Q1531518 . }
  # Cranganor is a suppressed historical see without P576 in Wikidata.
  FILTER(?item != wd:Q3621701)
  # Patriarcados apenas titulares/honoríficos não são jurisdições
  # territoriais independentes e não devem gerar pontos no mapa.
  FILTER(?item NOT IN (wd:Q616795, wd:Q1296901, wd:Q27780046))
  # Rome is represented by the Holy See layer and is canonically named a
  # diocese, despite also carrying a metropolitan class in Wikidata.
  FILTER(?item != wd:Q665037)

  OPTIONAL { ?item wdt:P625 ?directCoord . }
  OPTIONAL {
    ?item wdt:P159 ?headquarters .
    OPTIONAL { ?headquarters wdt:P625 ?headquartersCoord . }
    OPTIONAL { ?headquarters wdt:P17 ?headquartersCountry . }
  }
  OPTIONAL { ?item wdt:P17 ?itemCountry . }

  BIND(COALESCE(?itemCountry, ?headquartersCountry) AS ?country)
  OPTIONAL { ?country wdt:P297 ?countryCode . }
  OPTIONAL { ?country wdt:P30 ?continent . }
  OPTIONAL { ?item wdt:P856 ?officialUrl . }
  OPTIONAL { ?item wdt:P571 ?inception . }
  OPTIONAL { ?item wdt:P1866 ?catholicHierarchyId . }
  OPTIONAL { ?item wdt:P8389 ?gCatholicId . }

  SERVICE wikibase:label {
    bd:serviceParam wikibase:language "pt-br,pt,en" .
  }
}
`;

function qidFromUri(uri) {
  return uri?.split("/").at(-1) ?? null;
}

function parseCoordinate(wkt) {
  const match = /^Point\((-?\d+(?:\.\d+)?) (-?\d+(?:\.\d+)?)\)$/.exec(
    wkt ?? "",
  );
  if (!match) return null;

  const longitude = Number(match[1]);
  const latitude = Number(match[2]);
  if (
    !Number.isFinite(latitude) ||
    !Number.isFinite(longitude) ||
    latitude < -90 ||
    latitude > 90 ||
    longitude < -180 ||
    longitude > 180
  ) {
    return null;
  }

  return { latitude, longitude };
}

function normalizeName(label, canonicalType) {
  const replacements =
    canonicalType === "archeparchy" ||
    canonicalType === "metropolitan_archeparchy"
      ? [
          [/^Melkite Greek Catholic Archeparchy of /i, "Arquieparquia Greco-Melquita Católica de "],
          [/^Melkite Catholic Archeparchy of /i, "Arquieparquia Greco-Melquita Católica de "],
          [/^Maronite Catholic Archeparchy of /i, "Arquieparquia Maronita Católica de "],
          [/^Ukrainian Catholic Archeparchy of /i, "Arquieparquia Católica Ucraniana de "],
          [/^Chaldean Catholic Archeparchy of /i, "Arquieparquia Católica Caldeia de "],
          [/^Syro-Malabar Catholic Archeparchy of /i, "Arquieparquia Siro-Malabar de "],
          [/^Syro-Malankara Catholic Archeparchy of /i, "Arquieparquia Siro-Malancar de "],
          [/^Catholic Metropolitan Archieparchy of /i, "Arquieparquia Metropolitana de "],
          [/^Catholic Archieparchy of /i, "Arquieparquia de "],
          [/^Archaeparchy of /i, "Arquieparquia de "],
          [/^Archeparchy of /i, "Arquieparquia de "],
        ]
      : [
          [/^Roman Catholic Metropolitan Archdiocese of /i, "Arquidiocese Metropolitana de "],
          [/^Roman Catholic Archdiocese of /i, "Arquidiocese de "],
          [/^Metropolitan Archdiocese of /i, "Arquidiocese Metropolitana de "],
          [/^Archdiocese of /i, "Arquidiocese de "],
        ];

  for (const [pattern, replacement] of replacements) {
    if (pattern.test(label)) {
      return label.replace(pattern, replacement).replace(/\band\b/gi, "e");
    }
  }

  return label;
}

function yearFromDate(value) {
  if (!value) return null;
  const match = /^([+-]?\d{4,})-/.exec(value);
  if (!match) return null;
  const year = Number(match[1]);
  return Number.isSafeInteger(year) ? year : null;
}

function chooseContinent(continentQids, countryCode) {
  const candidates = continentQids
    .map((qid) => CONTINENT_BY_QID[qid])
    .filter(Boolean);

  if (candidates.length === 1) return candidates[0];

  const americas = new Set([
    "AR", "BO", "BR", "BZ", "CA", "CL", "CO", "CR", "CU", "DO",
    "EC", "GT", "GY", "HN", "HT", "JM", "MX", "NI", "PA", "PE",
    "PR", "PY", "SR", "SV", "TT", "US", "UY", "VE",
  ]);
  if (americas.has(countryCode)) return "americas";

  const asiaOverrides = new Set([
    "AM", "AZ", "CY", "GE", "IL", "KZ", "LB", "PS", "RU", "SY", "TR",
  ]);
  if (asiaOverrides.has(countryCode) && candidates.includes("asia")) {
    return "asia";
  }

  return candidates[0] ?? null;
}

function firstValue(values) {
  return [...values].sort((left, right) => left.localeCompare(right))[0] ?? null;
}

async function fetchBindings() {
  const url = new URL(ENDPOINT);
  url.searchParams.set("query", QUERY);
  url.searchParams.set("format", "json");

  const response = await fetch(url, {
    headers: {
      Accept: "application/sparql-results+json",
      "User-Agent": USER_AGENT,
    },
  });

  if (!response.ok) {
    throw new Error(`Wikidata respondeu ${response.status} ${response.statusText}`);
  }

  const payload = await response.json();
  return payload.results.bindings;
}

function normalizeBindings(bindings) {
  const grouped = new Map();

  for (const binding of bindings) {
    const qid = qidFromUri(binding.item?.value);
    const typeQid = qidFromUri(binding.type?.value);
    const type = TYPE_BY_QID[typeQid];
    if (!qid || !type) continue;

    const record = grouped.get(qid) ?? {
      qid,
      labels: new Set(),
      typeQids: new Set(),
      countryCodes: new Set(),
      continentQids: new Set(),
      directCoordinates: new Set(),
      headquartersCoordinates: new Set(),
      officialUrls: new Set(),
      inceptionYears: new Set(),
      catholicHierarchyIds: new Set(),
      gCatholicIds: new Set(),
    };

    if (binding.itemLabel?.value) record.labels.add(binding.itemLabel.value);
    record.typeQids.add(typeQid);
    if (binding.countryCode?.value) {
      record.countryCodes.add(binding.countryCode.value.toUpperCase());
    }
    const continentQid = qidFromUri(binding.continent?.value);
    if (continentQid) record.continentQids.add(continentQid);
    if (binding.directCoord?.value) {
      record.directCoordinates.add(binding.directCoord.value);
    }
    if (binding.headquartersCoord?.value) {
      record.headquartersCoordinates.add(binding.headquartersCoord.value);
    }
    if (binding.officialUrl?.value) {
      record.officialUrls.add(binding.officialUrl.value);
    }
    const inceptionYear = yearFromDate(binding.inception?.value);
    if (inceptionYear !== null) record.inceptionYears.add(inceptionYear);
    if (binding.catholicHierarchyId?.value) {
      record.catholicHierarchyIds.add(binding.catholicHierarchyId.value);
    }
    if (binding.gCatholicId?.value) {
      record.gCatholicIds.add(binding.gCatholicId.value);
    }

    grouped.set(qid, record);
  }

  return [...grouped.values()]
    .map((record) => {
      const typeQid = [...record.typeQids].sort((left, right) => {
        const leftMetropolitan = TYPE_BY_QID[left].canonicalType.includes("metropolitan");
        const rightMetropolitan = TYPE_BY_QID[right].canonicalType.includes("metropolitan");
        return Number(rightMetropolitan) - Number(leftMetropolitan);
      })[0];
      const type = TYPE_BY_QID[typeQid];
      const rawName = firstValue(record.labels) ?? record.qid;
      const countryCode = firstValue(record.countryCodes);
      const directCoordinate = parseCoordinate(firstValue(record.directCoordinates));
      const headquartersCoordinate = parseCoordinate(
        firstValue(record.headquartersCoordinates),
      );
      const coordinate = directCoordinate ?? headquartersCoordinate;
      const continentQids = [...record.continentQids].sort();

      const normalized = {
        qid: record.qid,
        wikidataUrl: `https://www.wikidata.org/wiki/${record.qid}`,
        name: normalizeName(rawName, type.canonicalType),
        canonicalType: type.canonicalType,
        tradition: type.tradition,
        countryCode,
        continent: chooseContinent(continentQids, countryCode),
        latitude: coordinate?.latitude ?? null,
        longitude: coordinate?.longitude ?? null,
        coordinateSource: directCoordinate
          ? "jurisdiction"
          : headquartersCoordinate
            ? "headquarters"
            : null,
        officialUrl: firstValue(record.officialUrls),
        erectedYear:
          record.inceptionYears.size > 0
            ? Math.min(...record.inceptionYears)
            : null,
        catholicHierarchyId: firstValue(record.catholicHierarchyIds),
        gCatholicId: firstValue(record.gCatholicIds),
      };

      return { ...normalized, ...(RECORD_OVERRIDES[record.qid] ?? {}) };
    })
    .sort((left, right) => left.qid.localeCompare(right.qid, "en", { numeric: true }));
}

function recordScore(record) {
  return (
    Number(record.latitude !== null && record.longitude !== null) * 20 +
    Number(Boolean(record.countryCode)) * 10 +
    Number(Boolean(record.officialUrl)) * 5 +
    Number(Boolean(RECORD_OVERRIDES[record.qid])) * 3
  );
}

function deduplicateRecords(records) {
  const chosenByExternalId = new Map();
  const recordsWithoutExternalId = [];

  for (const record of records) {
    const externalKey = record.gCatholicId
      ? `gcatholic:${record.gCatholicId}`
      : record.catholicHierarchyId
        ? `catholic-hierarchy:${record.catholicHierarchyId}`
        : null;
    if (!externalKey) {
      recordsWithoutExternalId.push(record);
      continue;
    }

    const current = chosenByExternalId.get(externalKey);
    if (!current || recordScore(record) > recordScore(current)) {
      chosenByExternalId.set(externalKey, record);
    }
  }

  return [...chosenByExternalId.values(), ...recordsWithoutExternalId].sort(
    (left, right) => left.qid.localeCompare(right.qid, "en", { numeric: true }),
  );
}

function audit(records) {
  const byType = Object.groupBy(records, (record) => record.canonicalType);
  const byContinent = Object.groupBy(
    records,
    (record) => record.continent ?? "unknown",
  );

  return {
    total: records.length,
    mapped: records.filter(
      (record) => record.latitude !== null && record.longitude !== null,
    ).length,
    withCountryCode: records.filter((record) => record.countryCode).length,
    withOfficialUrl: records.filter((record) => record.officialUrl).length,
    byType: Object.fromEntries(
      Object.entries(byType).map(([key, value]) => [key, value.length]),
    ),
    byContinent: Object.fromEntries(
      Object.entries(byContinent).map(([key, value]) => [key, value.length]),
    ),
    missingCoordinates: records
      .filter((record) => record.latitude === null || record.longitude === null)
      .map(({ qid, name, countryCode }) => ({ qid, name, countryCode })),
    missingCountryCode: records
      .filter((record) => !record.countryCode)
      .map(({ qid, name }) => ({ qid, name })),
  };
}

const outputArgumentIndex = process.argv.indexOf("--output");
const outputPath =
  outputArgumentIndex >= 0 ? process.argv[outputArgumentIndex + 1] : null;
if (outputArgumentIndex >= 0 && !outputPath) {
  throw new Error("Informe um caminho depois de --output.");
}

const bindings = await fetchBindings();
const records = deduplicateRecords([
  ...normalizeBindings(bindings),
  ...SUPPLEMENTAL_RECORDS,
]);
const snapshot = {
  source: ENDPOINT,
  sourceQuery: QUERY.trim(),
  license: "CC0-1.0",
  retrievedAt: new Date().toISOString(),
  records,
};

if (outputPath) {
  const absoluteOutputPath = resolve(outputPath);
  await mkdir(dirname(absoluteOutputPath), { recursive: true });
  await writeFile(
    absoluteOutputPath,
    `${JSON.stringify(snapshot, null, 2)}\n`,
    "utf8",
  );
}

console.log(JSON.stringify(audit(records), null, 2));
