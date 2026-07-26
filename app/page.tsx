"use client";

import { useCallback, useEffect, useState } from "react";
import { supabase } from "@/lib/supabase";
import SaintsMap, { SaintLocation } from "@/components/SaintsMap";
import TopBar, { SearchSuggestion } from "@/components/TopBar";
import Timeline, {
  BASE_MAX_YEAR,
  DEFAULT_YEAR,
  MIN_YEAR,
} from "@/components/Timeline";
import FactsPanel, { HistoricalEvent } from "@/components/FactsPanel";
import SaintsPanel, { SaintSummary } from "@/components/SaintsPanel";
import MapContextPanel, {
  MapContext,
  RouteLocation,
} from "@/components/MapContextPanel";
import {
  applyEventEditorial,
  applyLocationEditorial,
  applySaintEditorial,
} from "@/lib/catholicEditorial";
import {
  formatHistoricalYear,
  formatLifeSpan,
} from "@/lib/historicalYear";
import styles from "./page.module.css";

type Saint = SaintLocation & SaintSummary;

interface Pope {
  id: number;
  name: string;
  start_year: number;
  end_year: number | null;
  description: string | null;
}

type ContextTarget = { kind: "saint" | "event"; id: number };

const SELECTED_YEAR_STORAGE_KEY = "sancta-historia:selected-year";
const MAX_TIMEOUT_DELAY = 2_147_000_000;

function clampTimelineYear(value: number, maxYear: number) {
  return Math.min(Math.max(Math.trunc(value), MIN_YEAR), maxYear);
}

function normalizeSearchTerm(value: string) {
  return value
    .normalize("NFD")
    .replace(/\p{Diacritic}/gu, "")
    .toLocaleLowerCase("pt-BR")
    .replace(/[^\p{Letter}\p{Number}]+/gu, " ")
    .trim();
}

export default function Home() {
  const [year, setYear] = useState(DEFAULT_YEAR);
  const [maxYear, setMaxYear] = useState(BASE_MAX_YEAR);
  const [calendarReady, setCalendarReady] = useState(false);
  const [yearPreferenceLoaded, setYearPreferenceLoaded] = useState(false);

  const [saints, setSaints] = useState<Saint[]>([]);
  const [popes, setPopes] = useState<Pope[]>([]);
  const [events, setEvents] = useState<HistoricalEvent[]>([]);
  const [timelineLocations, setTimelineLocations] = useState<RouteLocation[]>([]);
  const [selectedSaintId, setSelectedSaintId] = useState<number | null>(null);
  const [previewSaintId, setPreviewSaintId] = useState<number | null>(null);
  const [selectedEventId, setSelectedEventId] = useState<number | null>(null);
  const [query, setQuery] = useState("");
  const [suggestions, setSuggestions] = useState<SearchSuggestion[]>([]);
  const [searching, setSearching] = useState(false);
  const [loading, setLoading] = useState(true);
  const [loadError, setLoadError] = useState<string | null>(null);
  const [contextTarget, setContextTarget] = useState<ContextTarget | null>(null);
  const [mapContext, setMapContext] = useState<MapContext | null>(null);
  const [contextLoading, setContextLoading] = useState(false);
  const [contextError, setContextError] = useState<string | null>(null);

  useEffect(() => {
    let calendarTimer = 0;

    function synchronizeCalendar() {
      const now = new Date();
      const currentYear = Math.max(BASE_MAX_YEAR, now.getFullYear());
      const nextYear = new Date(now.getFullYear() + 1, 0, 1);

      setMaxYear(currentYear);
      setCalendarReady(true);

      calendarTimer = window.setTimeout(
        synchronizeCalendar,
        Math.min(nextYear.getTime() - now.getTime() + 1_000, MAX_TIMEOUT_DELAY),
      );
    }

    calendarTimer = window.setTimeout(synchronizeCalendar, 0);
    return () => window.clearTimeout(calendarTimer);
  }, []);

  useEffect(() => {
    if (!calendarReady || yearPreferenceLoaded) return;

    const restorePreference = window.setTimeout(() => {
      try {
        const storedValue = window.localStorage.getItem(
          SELECTED_YEAR_STORAGE_KEY,
        );
        const storedYear =
          storedValue === null ? Number.NaN : Number(storedValue);

        if (Number.isInteger(storedYear)) {
          setYear(clampTimelineYear(storedYear, maxYear));
        }
      } catch {
        // Storage can be unavailable in hardened/private browser contexts.
      } finally {
        setYearPreferenceLoaded(true);
      }
    }, 0);

    return () => window.clearTimeout(restorePreference);
  }, [calendarReady, maxYear, yearPreferenceLoaded]);

  useEffect(() => {
    if (!yearPreferenceLoaded) return;

    try {
      window.localStorage.setItem(SELECTED_YEAR_STORAGE_KEY, String(year));
    } catch {
      // The timeline still works when storage is unavailable.
    }
  }, [year, yearPreferenceLoaded]);

  useEffect(() => {
    let active = true;

    async function loadData() {
      setLoading(true);
      setLoadError(null);

      const [saintsResult, popeResult, eventResult, locationsResult] =
        await Promise.all([
          supabase
            .from("saints_catalog")
            .select("*")
            .lte("birth_year", year)
            .gte("death_year", year)
            .order("birth_year"),
          supabase
            .from("popes")
            .select("*")
            .lte("start_year", year)
            .or(`end_year.gte.${year},end_year.is.null`)
            .order("start_year", { ascending: false })
            .limit(1),
          supabase
            .from("historical_events")
            .select("*")
            .lte("year", year)
            .order("year", { ascending: false })
            .limit(12),
          supabase
            .from("timeline_saint_points")
            .select("*")
            .lte("start_year", year)
            .gte("end_year", year)
            .order("sequence_order")
            .order("id"),
        ]);

      if (!active) return;
      const firstError =
        saintsResult.error ??
        popeResult.error ??
        eventResult.error ??
        locationsResult.error;
      if (firstError) {
        setLoadError("Não foi possível atualizar este período.");
      }

      setSaints((saintsResult.data || []).map(applySaintEditorial));
      setPopes(popeResult.data || []);
      setEvents((eventResult.data || []).map(applyEventEditorial));
      setTimelineLocations(
        (locationsResult.data ?? []).map(
          applyLocationEditorial,
        ) as RouteLocation[],
      );
      setLoading(false);
    }

    void loadData();
    return () => {
      active = false;
    };
  }, [year]);

  useEffect(() => {
    const term = query.trim();
    if (term.length < 2) {
      return;
    }

    let active = true;
    const timer = window.setTimeout(async () => {
      setSearching(true);
      const normalizedTerm = normalizeSearchTerm(term);

      const [saintsResult, eventsResult] = await Promise.all([
        supabase
          .from("saint_search_catalog")
          .select("id,name,birth_year,death_year,short_description")
          .ilike("search_text", `%${normalizedTerm}%`)
          .order("name")
          .limit(4),
        supabase
          .from("historical_events")
          .select("id,title,year,description")
          .ilike("title", `%${term}%`)
          .order("year", { ascending: false })
          .limit(4),
      ]);

      if (!active) return;

      const saintSuggestions: SearchSuggestion[] = (saintsResult.data ?? []).map(
        (record) => {
          const saint = applySaintEditorial(record);
          return {
          id: saint.id,
          kind: "saint",
          title: saint.name,
          subtitle: `${formatLifeSpan(
            saint.birth_year,
            saint.death_year,
          )}${
            saint.short_description ? ` · ${saint.short_description}` : ""
          }`,
          year: Math.min(Math.max(year, saint.birth_year), saint.death_year),
          };
        },
      );
      const eventSuggestions: SearchSuggestion[] = (eventsResult.data ?? []).map(
        (record) => {
          const event = applyEventEditorial(record);
          return {
          id: event.id,
          kind: "event",
          title: event.title,
          subtitle: `${formatHistoricalYear(event.year)}${
            event.description ? ` · ${event.description}` : ""
          }`,
          year: event.year,
          };
        },
      );

      setSuggestions([...saintSuggestions, ...eventSuggestions]);
      setSearching(false);
    }, 250);

    return () => {
      active = false;
      window.clearTimeout(timer);
    };
  }, [query, year]);

  const selectSaint = useCallback((saintId: number) => {
    setSelectedSaintId(saintId);
    setSelectedEventId(null);
    setContextTarget({ kind: "saint", id: saintId });
  }, []);

  useEffect(() => {
    if (!contextTarget) return;
    const target = contextTarget;

    let active = true;

    async function loadContext() {
      setContextLoading(true);
      setContextError(null);
      setMapContext(null);

      if (target.kind === "event") {
        const result = await supabase
          .from("historical_events")
          .select("*")
          .eq("id", target.id)
          .single();

        if (!active) return;
        if (result.error || !result.data) {
          setContextError("Não foi possível carregar este acontecimento.");
        } else {
          setMapContext({
            kind: "event",
            event: applyEventEditorial(result.data),
          });
        }
        setContextLoading(false);
        return;
      }

      const saintResult = await supabase
        .from("saints_catalog")
        .select("*")
        .eq("id", target.id)
        .single();

      if (!active) return;
      if (saintResult.error || !saintResult.data) {
        setContextError("Não foi possível carregar a trajetória deste santo.");
        setContextLoading(false);
        return;
      }

      const saint = applySaintEditorial(saintResult.data);
      const [locationsResult, eventsResult] = await Promise.all([
        supabase
          .from("timeline_saint_points")
          .select("*")
          .eq("saint_id", target.id)
          .order("sequence_order")
          .order("id"),
        supabase
          .from("historical_events")
          .select("*")
          .gte("year", saint.birth_year)
          .lte("year", saint.death_year)
          .order("year")
          .limit(8),
      ]);

      if (!active) return;
      if (locationsResult.error || eventsResult.error) {
        setContextError("Parte dos dados cartográficos não pôde ser carregada.");
      }

      setMapContext({
        kind: "saint",
        saint,
        locations: (locationsResult.data ?? []).map(
          applyLocationEditorial,
        ) as RouteLocation[],
        events: (eventsResult.data ?? []).map(applyEventEditorial),
      });
      setContextLoading(false);
    }

    void loadContext();
    return () => {
      active = false;
    };
  }, [contextTarget]);

  function selectSuggestion(suggestion: SearchSuggestion) {
    setQuery(suggestion.title);
    setYear(clampTimelineYear(suggestion.year, maxYear));
    if (suggestion.kind === "saint") {
      setSelectedSaintId(suggestion.id);
      setSelectedEventId(null);
      setContextTarget({ kind: "saint", id: suggestion.id });
    } else {
      setSelectedEventId(suggestion.id);
      setSelectedSaintId(null);
      setContextTarget({ kind: "event", id: suggestion.id });
    }
  }

  function closeContext() {
    setContextTarget(null);
    setMapContext(null);
    setContextError(null);
    setSelectedSaintId(null);
    setSelectedEventId(null);
  }

  const routeLocations =
    mapContext?.kind === "saint" ? mapContext.locations : [];
  const saintContextOpen = contextTarget?.kind === "saint";
  const contextOpen = contextTarget !== null;

  return (
    <main className={styles.page}>
      <SaintsMap
        saints={saintContextOpen ? [] : saints}
        selectedSaintId={selectedSaintId}
        previewSaintId={previewSaintId}
        onSelectSaint={selectSaint}
        timelineLocations={timelineLocations}
        routeLocations={routeLocations}
        contextOpen={contextOpen}
      />
      <div className={styles.goldWash} aria-hidden="true" />

      <div className={styles.interface}>
        <TopBar
          query={query}
          suggestions={suggestions}
          searching={searching}
          onQueryChange={(value) => {
            setQuery(value);
            if (value.trim().length < 2) {
              setSuggestions([]);
              setSearching(false);
            }
          }}
          onSelectSuggestion={selectSuggestion}
        />

        <div
          data-map-left-panel
          className={`${styles.leftPanel} ${
            contextOpen ? styles.leftPanelReceded : ""
          }`}
        >
          <FactsPanel
            events={events}
            selectedEventId={selectedEventId}
            onSelect={(event) => {
              setSelectedEventId(event.id);
              setSelectedSaintId(null);
              setYear(clampTimelineYear(event.year, maxYear));
              setContextTarget({ kind: "event", id: event.id });
            }}
          />
        </div>

        <div
          data-map-right-panel
          className={`${styles.rightPanel} ${
            contextOpen ? styles.rightPanelReceded : ""
          }`}
        >
          <SaintsPanel
            saints={saints}
            selectedSaintId={selectedSaintId}
            onSelect={(saint) => selectSaint(saint.id)}
            onPreview={setPreviewSaintId}
          />
        </div>

        <div
          data-map-timeline
          className={`${styles.timelineArea} ${
            contextOpen ? styles.timelineReceded : ""
          }`}
        >
          <Timeline
            year={year}
            maxYear={maxYear}
            onChange={(nextYear) => {
              setYear(clampTimelineYear(nextYear, maxYear));
              setSelectedEventId(null);
              setSelectedSaintId(null);
            }}
            pope={popes[0] ?? null}
          />
        </div>

        <div className={styles.statusArea} aria-live="polite">
          {loading && <span className={styles.loadingPill}>Atualizando período…</span>}
          {loadError && <span className={styles.errorPill}>{loadError}</span>}
        </div>

        {contextOpen && (
          <div className={styles.contextPanel} data-map-context-panel>
            <MapContextPanel
              context={mapContext}
              loading={contextLoading}
              error={contextError}
              onClose={closeContext}
            />
          </div>
        )}
      </div>
    </main>
  );
}
