"use client";

import {
  formatHistoricalPeriod,
  formatHistoricalYear,
  formatLifeSpan,
} from "@/lib/historicalYear";
import { BookIcon, ChevronLeftIcon, MedalIcon } from "./icons";

export interface SaintContextDetail {
  id: number;
  name: string;
  birth_year: number | null;
  death_year: number | null;
  birth_place: string | null;
  death_place: string | null;
  short_description: string | null;
  biography: string | null;
  feast_day: string | null;
  patron_of: string | null;
  religious_order: string | null;
  famous_quote: string | null;
}

export interface RouteLocation {
  id: number;
  saint_id: number;
  location_name: string;
  latitude: number | null;
  longitude: number | null;
  start_year: number | null;
  end_year: number | null;
  description: string | null;
  sequence_order?: number;
  date_precision?: "exact" | "year" | "approximate" | "range" | "unknown";
  historical_certainty?:
    | "documented"
    | "probable"
    | "traditional"
    | "disputed"
    | "unknown";
  point_kind?:
    | "life"
    | "mission"
    | "martyrdom"
    | "tradition"
    | "relics"
    | "posthumous_cult"
    | "other";
}

export interface ContextEvent {
  id: number;
  title: string;
  year: number;
  category: string | null;
  description: string | null;
}

export type MapContext =
  | {
      kind: "saint";
      saint: SaintContextDetail;
      locations: RouteLocation[];
      events: ContextEvent[];
    }
  | {
      kind: "event";
      event: ContextEvent;
    };

function formatPeriod(location: RouteLocation) {
  return formatHistoricalPeriod(location.start_year, location.end_year);
}

export default function MapContextPanel({
  context,
  loading,
  error,
  onClose,
}: {
  context: MapContext | null;
  loading: boolean;
  error: string | null;
  onClose: () => void;
}) {
  return (
    <section className="map-context-panel" aria-label="Contexto selecionado">
      <button type="button" className="context-back" onClick={onClose}>
        <ChevronLeftIcon className="h-4 w-4" />
        VOLTAR À VISÃO HISTÓRICA
      </button>

      {loading && (
        <div className="context-loading" aria-live="polite">
          <span className="search-spinner" />
          Preparando contexto cartográfico…
        </div>
      )}

      {error && <p className="context-error">{error}</p>}

      {!loading && context?.kind === "saint" && (
        <>
          <header className="context-heading">
            <span className="context-kicker">
              <MedalIcon className="h-4 w-4" />
              TRAJETÓRIA DE VIDA
            </span>
            <h1>{context.saint.name}</h1>
            <p className="context-period">
              {formatLifeSpan(
                context.saint.birth_year,
                context.saint.death_year,
              )}
              {context.saint.religious_order && ` · ${context.saint.religious_order}`}
            </p>
            {context.saint.short_description && (
              <p className="context-intro">{context.saint.short_description}</p>
            )}
          </header>

          <div className="context-scroll thin-scroll">
            <section className="context-section">
              <h2>VIDA E MISSÃO</h2>
              <p>
                {context.saint.biography ||
                  "A biografia completa deste santo ainda está em preparação."}
              </p>
            </section>

            <section className="context-section">
              <div className="context-section-title">
                <h2>PERCURSO NO MAPA</h2>
                <span>{context.locations.length} locais</span>
              </div>

              {context.locations.length ? (
                <ol className="route-list">
                  {context.locations.map((location, index) => (
                    <li key={location.id}>
                      <span className="route-index">{index + 1}</span>
                      <div>
                        <strong>{location.location_name}</strong>
                        {formatPeriod(location) && <small>{formatPeriod(location)}</small>}
                        {location.description && <p>{location.description}</p>}
                      </div>
                    </li>
                  ))}
                </ol>
              ) : (
                <p className="context-empty">
                  Ainda não há locais georreferenciados para esta trajetória.
                </p>
              )}
            </section>

            {!!context.events.length && (
              <section className="context-section">
                <h2>ACONTECIMENTOS CONTEMPORÂNEOS</h2>
                <div className="context-event-list">
                  {context.events.slice(0, 4).map((event) => (
                    <article key={event.id}>
                      <span>{formatHistoricalYear(event.year)}</span>
                      <div>
                        <strong>{event.title}</strong>
                        {event.description && <p>{event.description}</p>}
                      </div>
                    </article>
                  ))}
                </div>
              </section>
            )}

            {(context.saint.feast_day ||
              context.saint.patron_of ||
              context.saint.famous_quote) && (
              <section className="context-section context-notes">
                <h2>LEGADO</h2>
                {context.saint.feast_day && (
                  <p>
                    <strong>Memória litúrgica:</strong> {context.saint.feast_day}
                  </p>
                )}
                {context.saint.patron_of && (
                  <p>
                    <strong>Padroeiro de:</strong> {context.saint.patron_of}
                  </p>
                )}
                {context.saint.famous_quote && (
                  <blockquote>“{context.saint.famous_quote}”</blockquote>
                )}
              </section>
            )}
          </div>
        </>
      )}

      {!loading && context?.kind === "event" && (
        <>
          <header className="context-heading">
            <span className="context-kicker">
              <BookIcon className="h-4 w-4" />
              CONTEXTO HISTÓRICO
            </span>
            <h1>{context.event.title}</h1>
            <p className="context-period">
              {formatHistoricalYear(context.event.year)}
              {context.event.category && ` · ${context.event.category}`}
            </p>
          </header>

          <div className="context-scroll thin-scroll">
            <section className="context-section">
              <h2>O ACONTECIMENTO</h2>
              <p>
                {context.event.description ||
                  "A descrição completa deste acontecimento ainda está em preparação."}
              </p>
            </section>

            <section className="context-section context-map-note">
              <h2>LEITURA CARTOGRÁFICA</h2>
              <p>
                O mapa permanece no período do acontecimento, mostrando os santos e
                lugares já relacionados a esse recorte histórico.
              </p>
            </section>
          </div>
        </>
      )}
    </section>
  );
}
