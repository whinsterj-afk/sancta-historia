"use client";

import { useState } from "react";
import { BookIcon, ChevronRightIcon } from "./icons";

export interface HistoricalEvent {
  id: number;
  year: number;
  title: string;
  description: string | null;
}

export default function FactsPanel({ events }: { events: HistoricalEvent[] }) {
  const [expanded, setExpanded] = useState(false);
  const visible = expanded ? events : events.slice(0, 4);

  return (
    <aside className="historical-panel facts-panel">
      <div className="flex items-center gap-2 px-4 pt-4 pb-3 border-b gold-hairline">
        <BookIcon className="h-4 w-4 text-gold-400" />
        <h2 className="font-display text-xs tracking-[0.2em] text-gold-300">
          FATOS HISTÓRICOS
        </h2>
      </div>

      <div className="thin-scroll overflow-y-auto px-4 py-3 space-y-3">
        {visible.length === 0 && (
          <p className="text-sm text-parchment-dim italic">
            Nenhum fato registrado para este período.
          </p>
        )}

        {visible.map((event) => (
          <div key={event.id} className="flex gap-3 border-b gold-hairline last:border-0 pb-3">
            <div className="flex h-12 w-12 shrink-0 items-center justify-center rounded border border-gold-500/40 bg-ink-800 font-display text-gold-400 text-sm">
              {event.year}
            </div>
            <div className="min-w-0">
              <h3 className="font-semibold text-parchment leading-snug">{event.title}</h3>
              <p className="text-xs text-gold-400 mt-0.5">{event.year}</p>
              {event.description && (
                <p className="text-sm text-parchment-dim mt-1 leading-snug line-clamp-2">
                  {event.description}
                </p>
              )}
            </div>
          </div>
        ))}
      </div>

      {events.length > 4 && (
        <button
          type="button"
          onClick={() => setExpanded((v) => !v)}
          className="flex items-center justify-center gap-1 border-t gold-hairline py-3 text-xs tracking-[0.15em] text-gold-300 hover:bg-gold-500/10 transition"
        >
          {expanded ? "MOSTRAR MENOS" : "VER TODOS OS FATOS"}
          <ChevronRightIcon className={`h-3.5 w-3.5 transition ${expanded ? "rotate-90" : ""}`} />
        </button>
      )}
    </aside>
  );
}
