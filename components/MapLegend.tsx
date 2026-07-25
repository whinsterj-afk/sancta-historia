"use client";

import { useState } from "react";
import { ChevronDownIcon } from "./icons";

const ROWS = [
  { label: "Cidades importantes", swatch: "dot-filled" },
  { label: "Sedes episcopais", swatch: "dot-ring" },
  { label: "Locais de peregrinação", swatch: "pin" },
  { label: "Rotas históricas", swatch: "dotted" },
] as const;

function Swatch({ kind }: { kind: (typeof ROWS)[number]["swatch"] }) {
  if (kind === "dot-filled") {
    return <span className="h-2.5 w-2.5 rounded-full bg-gold-400" />;
  }
  if (kind === "dot-ring") {
    return <span className="h-2.5 w-2.5 rounded-full border border-gold-400" />;
  }
  if (kind === "pin") {
    return <span className="h-2.5 w-2.5 rotate-45 border border-gold-400" />;
  }
  return <span className="h-px w-3 border-t border-dashed border-gold-400" />;
}

export default function MapLegend() {
  const [open, setOpen] = useState(true);

  return (
    <div className="pointer-events-auto panel-glass border rounded-xl w-64 overflow-hidden">
      <button
        type="button"
        onClick={() => setOpen((v) => !v)}
        className="flex w-full items-center justify-between px-4 py-3 text-xs tracking-[0.15em] text-gold-300"
      >
        LEGENDA DO MAPA
        <ChevronDownIcon className={`h-3.5 w-3.5 transition-transform ${open ? "" : "-rotate-90"}`} />
      </button>

      {open && (
        <div className="px-4 pb-4 space-y-2 border-t gold-hairline pt-3">
          {ROWS.map((row) => (
            <div key={row.label} className="flex items-center gap-2 text-sm text-parchment-dim">
              <Swatch kind={row.swatch} />
              {row.label}
            </div>
          ))}
        </div>
      )}
    </div>
  );
}
