"use client";

import { formatHistoricalYear } from "@/lib/historicalYear";
import { BookIcon } from "./icons";

export interface HistoricalEvent {
  id: number;
  year: number;
  title: string;
  description: string | null;
}

export default function FactsPanel({
  events,
  selectedEventId,
  onSelect,
}: {
  events: HistoricalEvent[];
  selectedEventId?: number | null;
  onSelect?: (event: HistoricalEvent) => void;
}) {
  return (
    <aside className="historical-panel facts-panel">
      <div className="flex items-center gap-2 px-4 pt-4 pb-3 border-b gold-hairline">
        <BookIcon className="h-4 w-4 text-gold-400" />
        <h2 className="font-display text-xs tracking-[0.2em] text-gold-300">
          FATOS HISTÓRICOS
        </h2>
      </div>

      <div className="thin-scroll min-h-0 flex-1 overflow-y-auto overscroll-contain px-4 py-3 space-y-3">
        {events.length === 0 && (
          <p className="text-sm text-parchment-dim italic">
            Nenhum fato registrado para este período.
          </p>
        )}

        {events.map((event) => (
          <button
            key={event.id}
            type="button"
            className="fact-row flex w-full gap-3 border-b gold-hairline last:border-0 pb-3"
            data-selected={selectedEventId === event.id}
            aria-pressed={selectedEventId === event.id}
            onClick={() => onSelect?.(event)}
          >
            <div className="flex h-12 w-12 shrink-0 items-center justify-center rounded border border-gold-500/40 bg-ink-800 font-display text-gold-400 text-sm">
              {formatHistoricalYear(event.year)}
            </div>
            <div className="min-w-0 text-left">
              <h3 className="font-semibold text-parchment leading-snug">{event.title}</h3>
              {event.description && (
                <p className="text-sm text-parchment-dim mt-1 leading-snug line-clamp-2">
                  {event.description}
                </p>
              )}
            </div>
          </button>
        ))}
      </div>
    </aside>
  );
}
