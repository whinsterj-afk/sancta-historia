"use client";

import { ChevronLeftIcon, ChevronRightIcon, CrossIcon } from "./icons";

export interface Era {
  year: number;
  label: string;
}

export const ERAS: Era[] = [
  { year: 33, label: "I d.C." },
  { year: 400, label: "Concílios e Padres" },
  { year: 1054, label: "Cisma do Oriente" },
  { year: 1517, label: "Reforma Protestante" },
  { year: 1917, label: "Aparições de Fátima" },
  { year: 2025, label: "Atualidade" },
];

const MIN_YEAR = 1;
const MAX_YEAR = 2025;

function currentEra(year: number): Era {
  let match = ERAS[0];
  for (const era of ERAS) {
    if (era.year <= year) match = era;
  }
  return match;
}

function pct(year: number) {
  return ((year - MIN_YEAR) / (MAX_YEAR - MIN_YEAR)) * 100;
}

export default function Timeline({
  year,
  onChange,
  pope,
}: {
  year: number;
  onChange: (year: number) => void;
  pope?: { name: string; start_year: number; end_year: number } | null;
}) {
  const era = currentEra(year);
  const position = pct(year);
  const readoutPosition = Math.min(94, Math.max(6, position));

  function step(direction: -1 | 1) {
    const years = ERAS.map((e) => e.year);
    if (direction === 1) {
      const next = years.find((y) => y > year);
      onChange(next ?? MAX_YEAR);
    } else {
      const prev = [...years].reverse().find((y) => y < year);
      onChange(prev ?? MIN_YEAR);
    }
  }

  return (
    <div className="historical-timeline">
      <div className="flex items-center gap-3 sm:gap-6">
        <button
          type="button"
          onClick={() => step(-1)}
          aria-label="Era anterior"
          className="flex h-8 w-8 shrink-0 items-center justify-center rounded-full border border-gold-500/40 text-gold-300 hover:bg-gold-500/10 transition"
        >
          <ChevronLeftIcon className="h-4 w-4" />
        </button>

        <div className="relative flex-1 h-16">
          {/* current position readout */}
          <div
            className="absolute top-0 -translate-x-1/2 flex flex-col items-center"
            style={{ left: `${readoutPosition}%` }}
          >
            <CrossIcon className="h-3.5 w-3.5 text-gold-400" />
            <div className="font-display text-lg sm:text-xl leading-tight text-gold-200 mt-0.5">
              {year}
            </div>
            <div className="text-[10px] sm:text-xs tracking-[0.1em] text-gold-400 whitespace-nowrap">
              {era.label}
            </div>
            {pope && (
              <div className="text-[10px] text-parchment-dim whitespace-nowrap mt-0.5">
                Papa {pope.name} · {pope.start_year}–{pope.end_year}
              </div>
            )}
          </div>

          {/* track line */}
          <div className="absolute bottom-4 left-0 right-0 h-px bg-gold-500/30" />

          {/* era ticks */}
          {ERAS.map((e) => (
            <div
              key={e.year}
              className="absolute bottom-0 -translate-x-1/2 flex flex-col items-center"
              style={{ left: `${pct(e.year)}%` }}
            >
              <span className="h-2 w-2 rounded-full border border-gold-500/70 bg-ink-900" />
              <span className="mt-1 text-[10px] text-parchment-dim whitespace-nowrap hidden sm:block">
                {e.year}
              </span>
            </div>
          ))}

          <input
            type="range"
            min={MIN_YEAR}
            max={MAX_YEAR}
            value={year}
            onChange={(evt) => onChange(Number(evt.target.value))}
            aria-label="Ano selecionado"
            className="absolute bottom-0 left-0 right-0 h-6 w-full cursor-pointer opacity-0"
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
