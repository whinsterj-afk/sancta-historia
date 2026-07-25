"use client";

import { useState } from "react";
import Link from "next/link";
import { BookmarkIcon, ChevronRightIcon, MedalIcon } from "./icons";

export interface SaintSummary {
  id: number;
  name: string;
  birth_year: number;
  death_year: number;
  short_description: string | null;
}

function initials(name: string) {
  return name
    .replace(/^(São|Santa|Santo)\s+/i, "")
    .split(" ")
    .slice(0, 2)
    .map((w) => w[0])
    .join("")
    .toUpperCase();
}

export default function SaintsPanel({ saints }: { saints: SaintSummary[] }) {
  const [expanded, setExpanded] = useState(false);
  const [saved, setSaved] = useState<Set<number>>(new Set());
  const visible = expanded ? saints : saints.slice(0, 4);

  function toggleSaved(id: number) {
    setSaved((prev) => {
      const next = new Set(prev);
      if (next.has(id)) next.delete(id);
      else next.add(id);
      return next;
    });
  }

  return (
    <aside className="historical-panel saints-panel">
      <div className="flex items-center gap-2 px-4 pt-4 pb-3 border-b gold-hairline">
        <MedalIcon className="h-4 w-4 text-gold-400" />
        <h2 className="font-display text-xs tracking-[0.2em] text-gold-300">
          SANTOS DA ÉPOCA
        </h2>
      </div>

      <div className="thin-scroll overflow-y-auto px-4 py-3 space-y-3">
        {visible.length === 0 && (
          <p className="text-sm text-parchment-dim italic">
            Nenhum santo vivo neste período.
          </p>
        )}

        {visible.map((saint) => (
          <div key={saint.id} className="saint-row flex gap-3 border-b gold-hairline last:border-0 pb-3">
            <div className="saint-avatar flex h-12 w-12 shrink-0 items-center justify-center rounded-full border-2 border-gold-500/60 bg-ink-800 font-display text-gold-300 text-sm">
              {initials(saint.name)}
            </div>
            <div className="min-w-0 flex-1">
              <div className="flex items-start justify-between gap-2">
                <Link
                  href={`/saints/${saint.id}`}
                  className="font-semibold text-parchment hover:text-gold-300 transition leading-snug"
                >
                  {saint.name}
                </Link>
                <button
                  type="button"
                  onClick={() => toggleSaved(saint.id)}
                  aria-label="Favoritar"
                  className="text-gold-400 hover:text-gold-200 transition shrink-0"
                >
                  <BookmarkIcon className="h-4 w-4" filled={saved.has(saint.id)} />
                </button>
              </div>
              <p className="text-xs text-gold-400 mt-0.5">
                {saint.birth_year}–{saint.death_year}
              </p>
              {saint.short_description && (
                <p className="text-sm text-parchment-dim mt-1 leading-snug line-clamp-2">
                  {saint.short_description}
                </p>
              )}
            </div>
          </div>
        ))}
      </div>

      {saints.length > 4 && (
        <button
          type="button"
          onClick={() => setExpanded((v) => !v)}
          className="flex items-center justify-center gap-1 border-t gold-hairline py-3 text-xs tracking-[0.15em] text-gold-300 hover:bg-gold-500/10 transition"
        >
          {expanded ? "MOSTRAR MENOS" : "VER TODOS OS SANTOS"}
          <ChevronRightIcon className={`h-3.5 w-3.5 transition ${expanded ? "rotate-90" : ""}`} />
        </button>
      )}
    </aside>
  );
}
