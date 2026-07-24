"use client";

import dynamic from "next/dynamic";
import Link from "next/link";
import { useCallback, useEffect, useMemo, useState, useTransition } from "react";
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
  const [isScrubbing, setIsScrubbing] = useState(false);

  const visiblePeople = useMemo(
    () => [
      ...popes.slice(0, 2).map((pope) => ({
        id: `pope-${pope.id}`,
        href: `/papas/${pope.id}`,
        name: pope.name,
        label: "Papa",
        period: formatYearRange(pope.start_year, pope.end_year),
        description: pope.description,
      })),
      ...saints.slice(0, 5).map((saint) => ({
        id: `saint-${saint.id}`,
        href: `/saints/${saint.id}`,
        name: saint.name,
        label: "Santo",
        period: formatYearRangeShort(
          saint.birth_year,
          saint.death_year,
          saint.birth_year_note,
          saint.death_year_note
        ),
        description: saint.short_description,
      })),
    ],
    [popes, saints]
  );

  const commitTimeline = useCallback(
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
    if (isScrubbing) {
      return;
    }

    const timer = setTimeout(() => {
      commitTimeline(localYear, localMapMode);
    }, 420);

    return () => clearTimeout(timer);
  }, [commitTimeline, isScrubbing, localMapMode, localYear]);

  useEffect(() => {
    if (!isScrubbing) {
      return;
    }

    function handlePointerUp() {
      setIsScrubbing(false);
      commitTimeline(localYear, localMapMode);
    }

    window.addEventListener("pointerup", handlePointerUp);
    window.addEventListener("touchend", handlePointerUp);

    return () => {
      window.removeEventListener("pointerup", handlePointerUp);
      window.removeEventListener("touchend", handlePointerUp);
    };
  }, [commitTimeline, isScrubbing, localMapMode, localYear]);

  function setClampedYear(value: number) {
    if (!Number.isFinite(value)) {
      return;
    }

    setLocalYear(Math.min(Math.max(Math.round(value), minYear), maxYear));
  }

  return (
    <main className="sancta-map-stage relative min-h-screen overflow-hidden bg-[#11100e] text-[#fffaf0]">
      <div className="absolute inset-0">
        <MapView
          locations={locations}
          showPath={localMapMode === "journey"}
          variant="background"
        />
      </div>

      <div className="pointer-events-none absolute inset-0 bg-[linear-gradient(90deg,rgba(17,16,14,0.78)_0%,rgba(17,16,14,0.42)_31%,rgba(17,16,14,0.08)_58%,rgba(17,16,14,0.28)_100%)]" />
      <div className="pointer-events-none absolute inset-0 bg-[linear-gradient(180deg,rgba(17,16,14,0.62)_0%,rgba(17,16,14,0.08)_30%,rgba(17,16,14,0.18)_58%,rgba(17,16,14,0.76)_100%)]" />

      <section className="pointer-events-none relative z-10 flex min-h-screen flex-col justify-between px-4 pb-36 pt-36 sm:px-6 lg:px-10 lg:pb-40">
        <div className="max-w-md lg:max-w-lg">
          <p className="text-xs font-semibold uppercase tracking-[0.24em] text-[#e0c48e]">
            {formatYear(localYear)}
          </p>
          <h1 className="mt-3 text-4xl font-semibold leading-tight text-white sm:text-5xl">
            A historia viva da Igreja sobre o mapa
          </h1>
          <p className="mt-4 max-w-sm text-sm leading-6 text-[#f4e7d1]/86 sm:text-base">
            Santos, papas, eventos e lugares aparecem conforme voce percorre a
            linha do tempo.
          </p>
        </div>

        <div
          key={`${year}-${localMapMode}-${visiblePeople.map((item) => item.id).join("-")}`}
          className="pointer-events-auto mb-3 flex max-h-[42vh] w-full max-w-sm flex-col gap-3 overflow-hidden lg:mb-0"
        >
          {visiblePeople.length === 0 ? (
            <FloatingEmptyState year={localYear} />
          ) : (
            visiblePeople.map((item, index) => (
              <Link
                key={item.id}
                href={item.href}
                className="timeline-fade group rounded-lg border border-white/14 bg-[#201915]/62 p-4 text-left shadow-[0_18px_50px_rgba(0,0,0,0.28)] backdrop-blur-md transition hover:border-[#e0c48e]/70 hover:bg-[#2d231d]/72"
                style={{ animationDelay: `${index * 85}ms` }}
              >
                <div className="flex items-start justify-between gap-3">
                  <div>
                    <p className="text-[0.68rem] font-semibold uppercase tracking-[0.22em] text-[#e0c48e]">
                      {item.label}
                    </p>
                    <h2 className="mt-1 text-lg font-semibold leading-tight text-white">
                      {item.name}
                    </h2>
                  </div>
                  <span className="shrink-0 rounded-full border border-white/12 px-2 py-1 text-xs text-[#f4e7d1]/82">
                    {item.period}
                  </span>
                </div>
                {item.description && (
                  <p className="mt-2 overflow-hidden text-sm leading-5 text-[#f4e7d1]/78 [display:-webkit-box] [-webkit-box-orient:vertical] [-webkit-line-clamp:2]">
                    {item.description}
                  </p>
                )}
              </Link>
            ))
          )}
        </div>
      </section>

      <section className="fixed inset-x-0 bottom-0 z-20 px-3 pb-4 sm:px-6">
        <div className="mx-auto max-w-5xl rounded-lg border border-white/16 bg-[#211914]/78 p-4 text-[#fffaf0] shadow-[0_-18px_70px_rgba(0,0,0,0.36)] backdrop-blur-xl sm:p-5">
          <div className="mb-4 flex flex-col gap-3 lg:flex-row lg:items-center lg:justify-between">
            <div>
              <p className="text-xs font-semibold uppercase tracking-[0.24em] text-[#e0c48e]">
                Linha do tempo
              </p>
              <h2 className="mt-1 text-2xl font-semibold">
                {formatYear(localYear)}
              </h2>
            </div>

            <div className="flex flex-wrap items-center gap-2">
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
                Trajetorias
              </ModeButton>
              {isPending && (
                <span className="rounded-full border border-white/12 px-3 py-2 text-xs text-[#f4e7d1]/72">
                  Atualizando
                </span>
              )}
            </div>
          </div>

          <div className="grid gap-4 lg:grid-cols-[1fr_8rem] lg:items-center">
            <input
              type="range"
              min={minYear}
              max={maxYear}
              value={localYear}
              onPointerDown={() => setIsScrubbing(true)}
              onTouchStart={() => setIsScrubbing(true)}
              onChange={(event) => setClampedYear(Number(event.target.value))}
              onBlur={() => commitTimeline(localYear, localMapMode)}
              className="timeline-range w-full"
              aria-label="Ano da linha do tempo"
            />

            <input
              type="number"
              min={minYear}
              max={maxYear}
              value={localYear}
              onChange={(event) => setClampedYear(Number(event.target.value))}
              onBlur={() => commitTimeline(localYear, localMapMode)}
              onKeyDown={(event) => {
                if (event.key === "Enter") {
                  commitTimeline(localYear, localMapMode);
                }
              }}
              className="h-11 rounded-md border border-white/18 bg-white/[0.09] px-3 text-center text-lg font-semibold text-white outline-none transition focus:border-[#e0c48e]"
              aria-label="Ano selecionado"
            />
          </div>

          <div className="mt-4 flex gap-2 overflow-x-auto pb-1">
            {significantYears.map((quickYear) => (
              <button
                key={quickYear}
                type="button"
                onClick={() => setClampedYear(quickYear)}
                className="shrink-0 rounded-full border border-white/14 bg-white/[0.08] px-3 py-1.5 text-xs font-medium text-[#f4e7d1] transition hover:border-[#e0c48e] hover:bg-[#e0c48e]/16"
              >
                {quickYear}
              </button>
            ))}
          </div>

          <div className="mt-4 grid grid-cols-2 gap-2 text-xs text-[#f4e7d1]/74 sm:grid-cols-4">
            <StatPill label="Santos" value={stats.saints} />
            <StatPill label="Papas" value={stats.popes} />
            <StatPill label="Eventos" value={stats.events} />
            <StatPill label="Locais" value={locations.length} />
          </div>

          {events.length > 0 && (
            <p className="mt-3 truncate text-xs text-[#f4e7d1]/68">
              {formatYear(events[0].year)} - {events[0].title}
            </p>
          )}
        </div>
      </section>
    </main>
  );
}

function FloatingEmptyState({ year }: { year: number }) {
  return (
    <div className="timeline-fade rounded-lg border border-white/14 bg-[#201915]/62 p-4 shadow-[0_18px_50px_rgba(0,0,0,0.28)] backdrop-blur-md">
      <p className="text-xs font-semibold uppercase tracking-[0.22em] text-[#e0c48e]">
        {formatYear(year)}
      </p>
      <p className="mt-2 text-sm leading-5 text-[#f4e7d1]/82">
        Nenhum santo ou papa encontrado para este recorte.
      </p>
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
      className={`rounded-full border px-3 py-2 text-xs font-semibold transition ${
        active
          ? "border-[#e0c48e] bg-[#e0c48e] text-[#211914]"
          : "border-white/14 bg-white/[0.08] text-[#f4e7d1] hover:border-[#e0c48e] hover:bg-[#e0c48e]/16"
      }`}
    >
      {children}
    </button>
  );
}

function StatPill({ label, value }: { label: string; value: number }) {
  return (
    <div className="rounded-md border border-white/10 bg-white/[0.07] px-3 py-2">
      <span className="font-semibold text-white">{value}</span> {label}
    </div>
  );
}
