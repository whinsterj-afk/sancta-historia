"use client";

import {
  formatHistoricalPeriod,
  formatHistoricalYear,
} from "@/lib/historicalYear";
import { ChevronLeftIcon, ChevronRightIcon, CrossIcon } from "./icons";

export interface Era {
  year: number;
  label: string;
}

export const ERAS: Era[] = [
  { year: 0, label: "Origens do Cristianismo" },
  { year: 33, label: "Igreja apostólica" },
  { year: 400, label: "Concílios e Padres" },
  { year: 1054, label: "Cisma do Oriente" },
  { year: 1517, label: "Reforma Protestante" },
  { year: 1917, label: "Aparições de Fátima" },
];

export const MIN_YEAR = 0;
export const BASE_MAX_YEAR = 2025;
export const DEFAULT_YEAR = 1917;

function currentEra(year: number, eras: Era[]): Era {
  let match = eras[0];
  for (const era of eras) {
    if (era.year <= year) match = era;
  }
  return match;
}

function pct(year: number, maxYear: number) {
  const range = Math.max(maxYear - MIN_YEAR, 1);
  return ((year - MIN_YEAR) / range) * 100;
}

export default function Timeline({
  year,
  maxYear,
  onChange,
  pope,
}: {
  year: number;
  maxYear: number;
  onChange: (year: number) => void;
  pope?: {
    name: string;
    start_year: number;
    end_year: number | null;
  } | null;
}) {
  const eras = [...ERAS, { year: maxYear, label: "Atualidade" }];
  const era = currentEra(year, eras);
  const position = pct(year, maxYear);

  function step(direction: -1 | 1) {
    const years = eras.map((e) => e.year);
    if (direction === 1) {
      const next = years.find((y) => y > year);
      onChange(next ?? maxYear);
    } else {
      const prev = [...years].reverse().find((y) => y < year);
      onChange(prev ?? MIN_YEAR);
    }
  }

  return (
    <div className="historical-timeline">
      <div className="timeline-readout">
        <CrossIcon className="timeline-cross h-3.5 w-3.5 text-gold-400" />
        <div className="timeline-date">
          <span className="timeline-year">{formatHistoricalYear(year)}</span>
          <span className="timeline-era">{era.label}</span>
        </div>
        <div className="timeline-context" aria-live="polite">
          {pope ? (
            <>
              <span>{pope.name}</span>
              <small>
                Pontificado ·{" "}
                {formatHistoricalPeriod(pope.start_year, pope.end_year) ??
                  "presente"}
              </small>
            </>
          ) : (
            <small>Período sem pontífice registrado</small>
          )}
        </div>
      </div>

      <div className="timeline-controls">
        <button
          type="button"
          onClick={() => step(-1)}
          aria-label="Era anterior"
          className="flex h-8 w-8 shrink-0 items-center justify-center rounded-full border border-gold-500/40 text-gold-300 hover:bg-gold-500/10 transition"
        >
          <ChevronLeftIcon className="h-4 w-4" />
        </button>

        <div className="timeline-rail">
          <div className="timeline-track">
            <span className="timeline-progress" style={{ width: `${position}%` }} />
            <span className="timeline-handle" style={{ left: `${position}%` }} />
          </div>

          {eras.map((e, index) => (
            <div
              key={e.year}
              className={[
                "timeline-tick",
                index % 2 === 1 ? "timeline-tick--staggered" : "",
                e.year === MIN_YEAR ? "timeline-tick--start" : "",
                e.year === maxYear ? "timeline-tick--end" : "",
                e.year === 33 ? "timeline-tick--early" : "",
              ]
                .filter(Boolean)
                .join(" ")}
              style={{ left: `${pct(e.year, maxYear)}%` }}
            >
              <span className="timeline-tick-dot" />
              <span className="timeline-tick-label">
                {formatHistoricalYear(e.year)}
              </span>
            </div>
          ))}

          <input
            type="range"
            min={MIN_YEAR}
            max={maxYear}
            value={year}
            onChange={(evt) => onChange(Number(evt.target.value))}
            aria-label="Ano selecionado"
            aria-valuetext={`${formatHistoricalYear(year)}, ${era.label}`}
            className="timeline-range"
          />
        </div>

        <button
          type="button"
          onClick={() => step(1)}
          aria-label="Próxima era"
          className="flex h-8 w-8 shrink-0 items-center justify-center rounded-full border border-gold-500/40 text-gold-300 hover:bg-gold-500/10 transition"
        >
          <ChevronRightIcon className="h-4 w-4" />
        </button>
      </div>
    </div>
  );
}
