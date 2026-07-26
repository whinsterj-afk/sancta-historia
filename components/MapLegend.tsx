"use client";

import { useState } from "react";
import { ChevronDownIcon } from "./icons";

const ROWS = [
  { label: "Santos", swatch: "saint" },
  { label: "Cidades importantes", swatch: "important-city" },
  { label: "Sedes episcopais", swatch: "episcopal-see" },
  { label: "Locais de peregrinação", swatch: "pilgrimage-site" },
  { label: "Rotas históricas", swatch: "route" },
] as const;

const CHURCH_ROWS = [
  { label: "Santa Sé", swatch: "holy-see" },
  { label: "Arquidioceses metropolitanas", swatch: "metropolitan" },
  { label: "Dioceses e equivalentes", swatch: "diocese" },
  { label: "Paróquias e capelas", swatch: "parish" },
] as const;

type SwatchKind =
  | (typeof ROWS)[number]["swatch"]
  | (typeof CHURCH_ROWS)[number]["swatch"];

function Swatch({ kind }: { kind: SwatchKind }) {
  if (kind === "saint") {
    return <span className="legend-saint-symbol">S</span>;
  }
  if (kind === "route") {
    return <span className="legend-route-symbol" />;
  }
  if (
    kind === "holy-see" ||
    kind === "metropolitan" ||
    kind === "diocese" ||
    kind === "parish"
  ) {
    return (
      <span
        className={`legend-church-structure legend-church-structure--${kind}`}
        aria-hidden="true"
      >
        <span />
      </span>
    );
  }
  return (
    <span
      className={`landmark-symbol landmark-symbol--${kind}`}
      aria-hidden="true"
    />
  );
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
          <div className="pt-2 text-[10px] tracking-[0.14em] text-gold-500">
            ESTRUTURA DA IGREJA
          </div>
          {CHURCH_ROWS.map((row) => (
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
