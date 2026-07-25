"use client";

import { useState } from "react";
import { ClockIcon, DomeIcon, FootprintsIcon, InfoIcon, LayersIcon } from "./icons";

const ITEMS = [
  { key: "camadas", label: "Camadas", Icon: LayersIcon },
  { key: "timeline", label: "Linha do Tempo", Icon: ClockIcon },
  { key: "overview", label: "Visão Geral", Icon: DomeIcon },
  { key: "peregrinacoes", label: "Peregrinações", Icon: FootprintsIcon },
  { key: "sobre", label: "Sobre o Projeto", Icon: InfoIcon },
] as const;

export default function BottomNav({ onAbout }: { onAbout: () => void }) {
  const [active, setActive] = useState<string>("overview");

  return (
    <nav className="historical-nav">
      {ITEMS.map(({ key, label, Icon }) => {
        const isCenter = key === "overview";
        const isActive = active === key;
        return (
          <button
            key={key}
            type="button"
            title={label}
            aria-label={label}
            onClick={() => {
              setActive(key);
              if (key === "sobre") onAbout();
            }}
            className={`flex items-center justify-center rounded-full transition ${
              isCenter ? "h-14 w-14" : "h-10 w-10"
            } ${
              isActive
                ? "bg-gold-500 text-ink-950"
                : "text-gold-300 hover:bg-gold-500/10"
            } ${isCenter && !isActive ? "border border-gold-500/50" : ""}`}
          >
            <Icon className={isCenter ? "h-6 w-6" : "h-4 w-4"} />
          </button>
        );
      })}
    </nav>
  );
}
