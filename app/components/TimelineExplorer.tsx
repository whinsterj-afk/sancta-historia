"use client";

import dynamic from "next/dynamic";
import Link from "next/link";
import { useCallback, useEffect, useState, useTransition } from "react";
import { useRouter } from "next/navigation";
import {
  formatYear,
  formatYearRange,
  formatYearRangeShort,
} from "@/lib/formatYear";
import type {
  HistoricalEvent,
  Location,
  Pope,
  Saint,
  SiteStats,
  TimelineMapMode,
} from "@/lib/types";

const MapView = dynamic(() => import("./MapView"), {
  ssr: false,
});

type TimelineExplorerProps = {
  year: number;
  minYear: number;
  maxYear: number;
  significantYears: number[];
  mapMode: TimelineMapMode;
  stats: SiteStats;
  saints: Saint[];
  popes: Pope[];
  events: HistoricalEvent[];
  locations: Location[];
};

export default function TimelineExplorer({
  year,
  minYear,
  maxYear,
  significantYears,
  mapMode,
  stats,
  saints,
  popes,
  events,
  locations,
}: TimelineExplorerProps) {
  const router = useRouter();
  const [isPending, startTransition] = useTransition();
  const [localYear, setLocalYear] = useState(year);
  const [localMapMode, setLocalMapMode] = useState<TimelineMapMode>(mapMode);

  const updateTimeline = useCallback(
    (nextYear: number, nextMapMode: TimelineMapMode) => {
      if (nextYear === year && nextMapMode === mapMode) {
        return;
      }

      const params = new URLSearchParams();
      params.set("year", String(nextYear));

      if (nextMapMode !== "year") {
        params.set("mode", nextMapMode);
      }

      startTransition(() => {
        router.replace(`/?${params.toString()}`);
      });
    },
    [mapMode, router, year]
  );

  useEffect(() => {
    const timer = setTimeout(() => {
      updateTimeline(localYear, localMapMode);
    }, 350);

    return () => clearTimeout(timer);
  }, [localYear, localMapMode, updateTimeline]);

  function setClampedYear(value: number) {
    if (!Number.isFinite(value)) {
      return;
    }

    setLocalYear(Math.min(Math.max(Math.round(value), minYear), maxYear));
  }

  return (
    <main className="min-h-screen max-w-7xl mx-auto p-8">
      <section className="mb-8">
        <h1 className="text-5xl md:text-6xl font-bold mb-3 tracking-tight text-[#2b1b10]">
          Sancta Historia
        </h1>

        <p className="max-w-3xl text-lg text-[#4b3a2a]">
          Explore 2.000 anos de história da Igreja Católica por santos, papas,
          eventos históricos e lugares que marcaram a fé cristã.
        </p>
      </section>

      <section className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-10">
        <StatCard label="Santos cadastrados" value={stats.saints} />
        <StatCard label="Papas" value={stats.popes} />
        <StatCard label="Eventos históricos" value={stats.events} />
        <StatCard label="Locais no mapa" value={stats.locations} />
      </section>

      <section className="mb-8 rounded-2xl border border-[#c9b895] bg-[#fffaf0] p-5 shadow-sm">
        <div className="mb-4 flex flex-col gap-2 md:flex-row md:items-end md:justify-between">
          <div>
            <p className="text-sm uppercase tracking-[0.24em] text-[#8b5e24]">
              Linha do tempo
            </p>
            <h2 className="text-2xl font-semibold text-[#2b1b10]">
              Ano selecionado: {formatYear(localYear)}
            </h2>
          </div>

          {isPending && (
            <p className="text-sm text-[#6b543d]">Atualizando contexto...</p>
          )}
        </div>

        <div className="mb-4 flex flex-col gap-4 md:flex-row md:items-center">
          <input
            type="range"
            min={minYear}
            max={maxYear}
            value={localYear}
            onChange={(event) => setClampedYear(Number(event.target.value))}
            className="w-full"
          />

          <input
            type="number"
            min={minYear}
            max={maxYear}
            value={localYear}
            onChange={(event) => setClampedYear(Number(event.target.value))}
            className="w-36 rounded-lg border border-[#c9b895] bg-white px-3 py-2 text-lg"
          />
        </div>

        <div className="flex flex-wrap gap-2">
          {significantYears.map((quickYear) => (
            <button
              key={quickYear}
              type="button"
              onClick={() => setClampedYear(quickYear)}
              className="rounded-lg border border-[#c9b895] bg-white px-3 py-1 text-sm text-[#4b3a2a] transition hover:bg-[#eadfcb]"
            >
              {quickYear}
            </button>
          ))}
        </div>
      </section>

      <section id="mapa" className="mb-8">
        <div className="mb-4 flex flex-col gap-3 md:flex-row md:items-center md:justify-between">
          <div>
            <p className="text-sm uppercase tracking-[0.24em] text-[#8b5e24]">
              Geografia histórica
            </p>
            <h2 className="text-2xl font-bold text-[#2b1b10]">Mapa</h2>
          </div>

          <div className="flex gap-2">
            <ModeButton
              active={localMapMode === "year"}
              onClick={() => setLocalMapMode("year")}
            >
              Locais do ano
            </ModeButton>
            <ModeButton
              active={localMapMode === "journey"}
              onClick={() => setLocalMapMode("journey")}
            >
              Trajetórias
            </ModeButton>
          </div>
        </div>

        <MapView locations={locations} showPath={mapMode === "journey"} />

        <p className="mt-2 text-sm text-[#6b543d]">
          Locais exibidos no mapa: {locations.length}
        </p>
      </section>

      <section className="grid gap-6 md:grid-cols-3">
        <InfoPanel title="Papa">
          {popes.length === 0 && <p>Nenhum papa encontrado.</p>}

          {popes.map((pope) => (
            <div key={pope.id} className="border-b border-[#c9b895] pb-3">
              <Link
                href={`/papas/${pope.id}`}
                className="font-semibold text-[#2b1b10] hover:text-[#8b5e24]"
              >
                {pope.name}
              </Link>
              <p className="text-sm text-[#6b543d]">
                {formatYearRange(pope.start_year, pope.end_year)}
              </p>
              {pope.description && (
                <p className="mt-2 text-sm text-[#4b3a2a]">
                  {pope.description}
                </p>
              )}
            </div>
          ))}
        </InfoPanel>

        <InfoPanel title="Santos vivos">
          {saints.length === 0 && <p>Nenhum santo encontrado.</p>}

          {saints.map((saint) => (
            <div key={saint.id} className="border-b border-[#c9b895] pb-3">
              <Link
                href={`/saints/${saint.id}`}
                className="font-semibold text-[#2b1b10] hover:text-[#8b5e24]"
              >
                {saint.name}
              </Link>
              <p className="text-sm text-[#6b543d]">
                {formatYearRangeShort(
                  saint.birth_year,
                  saint.death_year,
                  saint.birth_year_note,
                  saint.death_year_note
                )}
              </p>
              {saint.short_description && (
                <p className="mt-2 text-sm text-[#4b3a2a]">
                  {saint.short_description}
                </p>
              )}
            </div>
          ))}
        </InfoPanel>

        <InfoPanel title="Eventos históricos">
          {events.length === 0 && <p>Nenhum evento encontrado.</p>}

          {events.map((event) => (
            <div key={event.id} className="border-b border-[#c9b895] pb-3">
              <Link
                href={`/eventos/${event.id}`}
                className="font-semibold text-[#2b1b10] hover:text-[#8b5e24]"
              >
                {formatYear(event.year)} - {event.title}
              </Link>
              {event.category && (
                <p className="mt-1 text-xs uppercase tracking-wide text-[#8b5e24]">
                  {event.category}
                </p>
              )}
              {event.description && (
                <p className="mt-2 text-sm text-[#4b3a2a]">
                  {event.description}
                </p>
              )}
            </div>
          ))}
        </InfoPanel>
      </section>
    </main>
  );
}

function StatCard({ label, value }: { label: string; value: number }) {
  return (
    <div className="rounded-2xl border border-[#c9b895] bg-[#fffaf0] p-4 shadow-sm">
      <p className="text-3xl font-bold text-[#5f3b16]">{value}</p>
      <p className="text-sm text-[#4b3a2a]">{label}</p>
    </div>
  );
}

function ModeButton({
  active,
  children,
  onClick,
}: {
  active: boolean;
  children: React.ReactNode;
  onClick: () => void;
}) {
  return (
    <button
      type="button"
      onClick={onClick}
      className={`rounded-lg border px-4 py-2 text-sm transition ${
        active
          ? "border-[#2b1b10] bg-[#2b1b10] text-[#fffaf0]"
          : "border-[#c9b895] bg-[#fffaf0] text-[#4b3a2a] hover:bg-[#eadfcb]"
      }`}
    >
      {children}
    </button>
  );
}

function InfoPanel({
  children,
  title,
}: {
  children: React.ReactNode;
  title: string;
}) {
  return (
    <div className="rounded-2xl border border-[#c9b895] bg-[#fffaf0] p-6 shadow-sm">
      <h2 className="mb-4 text-2xl font-bold text-[#2b1b10]">{title}</h2>
      <div className="space-y-3 text-[#4b3a2a]">{children}</div>
    </div>
  );
}
