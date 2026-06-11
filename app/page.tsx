"use client";

import { useEffect, useState } from "react";
import Link from "next/link";
import dynamic from "next/dynamic";
import { supabase } from "@/lib/supabase";

const MapView = dynamic(() => import("./components/MapView"), {
  ssr: false,
});

export default function Home() {
  const [year, setYear] = useState(1220);

  const [saints, setSaints] = useState<any[]>([]);
  const [popes, setPopes] = useState<any[]>([]);
  const [events, setEvents] = useState<any[]>([]);
  const [locations, setLocations] = useState<any[]>([]);
  const [mapMode, setMapMode] = useState<"year" | "journey">("year");
  const [stats, setStats] = useState({
  saints: 0,
  popes: 0,
  events: 0,
  locations: 0,
});

  useEffect(() => {
  loadData();
}, [year, mapMode]);
useEffect(() => {
  loadStats();
}, []);

  async function loadData() {
    const { data: saintsData } = await supabase
      .from("saints")
      .select("*")
      .lte("birth_year", year)
      .gte("death_year", year)
      .order("birth_year");

    const { data: popeData } = await supabase
      .from("popes")
      .select("*")
      .lte("start_year", year)
      .gte("end_year", year);

    const { data: eventData } = await supabase
      .from("historical_events")
      .select("*")
      .lte("year", year)
      .order("year", { ascending: false })
      .limit(5);

    let locationData: any[] | null = [];
    
    async function loadStats() {
  const saintsCount = await supabase
    .from("saints")
    .select("*", { count: "exact", head: true });

  const popesCount = await supabase
    .from("popes")
    .select("*", { count: "exact", head: true });

  const eventsCount = await supabase
    .from("historical_events")
    .select("*", { count: "exact", head: true });

  const locationsCount = await supabase
    .from("locations")
    .select("*", { count: "exact", head: true });

  setStats({
    saints: saintsCount.count || 0,
    popes: popesCount.count || 0,
    events: eventsCount.count || 0,
    locations: locationsCount.count || 0,
  });
}

if (mapMode === "year") {
  const result = await supabase
    .from("locations")
    .select("*, saints(name)")
    .lte("start_year", year)
    .gte("end_year", year);

  locationData = result.data;
}

if (mapMode === "journey") {
  const saintIds = saintsData?.map((saint) => saint.id) || [];

  if (saintIds.length > 0) {
    const result = await supabase
      .from("locations")
      .select("*, saints(name)")
      .in("saint_id", saintIds);

    locationData = result.data;
  }
}

    setSaints(saintsData || []);
    setPopes(popeData || []);
    setEvents(eventData || []);
    setLocations(locationData || []);
  }
    async function loadStats() {
    const saintsCount = await supabase
      .from("saints")
      .select("*", { count: "exact", head: true });

    const popesCount = await supabase
      .from("popes")
      .select("*", { count: "exact", head: true });

    const eventsCount = await supabase
      .from("historical_events")
      .select("*", { count: "exact", head: true });

    const locationsCount = await supabase
      .from("locations")
      .select("*", { count: "exact", head: true });

    setStats({
      saints: saintsCount.count || 0,
      popes: popesCount.count || 0,
      events: eventsCount.count || 0,
      locations: locationsCount.count || 0,
    });
  }

  return (
    <main className="min-h-screen max-w-7xl mx-auto p-8">
      <h1 className="text-6xl font-bold mb-2 tracking-tight text-[#2b1b10]">
  Sancta Historia
</h1>

<p className="text-lg text-[#4b3a2a] mb-6">
  Explore 2.000 anos de história da Igreja Católica através da linha do tempo,
  dos santos, dos papas, dos eventos históricos e dos lugares que marcaram a
  fé cristã.
</p>

<div className="grid grid-cols-2 md:grid-cols-4 gap-4 mb-10">
  <div className="bg-[#fffaf0] border border-[#c9b895] rounded-2xl p-4 shadow-sm">
    <p className="text-3xl font-bold text-[#5f3b16]">
      {stats.saints}
    </p>
    <p className="text-sm text-[#4b3a2a]">
      Santos cadastrados
    </p>
  </div>

  <div className="bg-[#fffaf0] border border-[#c9b895] rounded-2xl p-4 shadow-sm">
    <p className="text-3xl font-bold text-[#5f3b16]">
      {stats.popes}
    </p>
    <p className="text-sm text-[#4b3a2a]">
      Papas
    </p>
  </div>

  <div className="bg-[#fffaf0] border border-[#c9b895] rounded-2xl p-4 shadow-sm">
    <p className="text-3xl font-bold text-[#5f3b16]">
      {stats.events}
    </p>
    <p className="text-sm text-[#4b3a2a]">
      Eventos históricos
    </p>
  </div>

  <div className="bg-[#fffaf0] border border-[#c9b895] rounded-2xl p-4 shadow-sm">
    <p className="text-3xl font-bold text-[#5f3b16]">
      {stats.locations}
    </p>
    <p className="text-sm text-[#4b3a2a]">
      Locais no mapa
    </p>
  </div>
</div>

      <div className="mb-8">
  <h2 className="text-2xl font-semibold mb-4">
    Ano Selecionado: {year}
  </h2>

  <div className="flex flex-col md:flex-row gap-4 md:items-center mb-4">
    <input
      type="range"
      min="1"
      max="2026"
      value={year}
      onChange={(e) => setYear(Number(e.target.value))}
      className="w-full"
    />

    <input
      type="number"
      min="1"
      max="2026"
      value={year}
      onChange={(e) => {
        const typedYear = Number(e.target.value);

        if (!Number.isNaN(typedYear)) {
          setYear(typedYear);
        }
      }}
      className="w-32 border border-[#c9b895] rounded-lg px-3 py-2 text-lg bg-[#fffaf0]"
    />
  </div>

  <div className="flex gap-2 flex-wrap">
    {[33, 325, 800, 1095, 1220, 1517, 1545, 1962, 1978, 2005].map(
      (quickYear) => (
        <button
          key={quickYear}
          onClick={() => setYear(quickYear)}
          className="px-3 py-1 border border-[#c9b895] rounded-lg text-sm bg-[#fffaf0] hover:bg-[#eadfcb] transition"
        >
          {quickYear}
        </button>
      )
    )}
  </div>
</div>

      <section id="mapa" className="mb-8">
        <h2 className="text-2xl font-bold mb-4">
          Mapa Histórico
        </h2>
        <div className="flex gap-2 mb-4">
  <button
    onClick={() => setMapMode("year")}
    className={`px-4 py-2 rounded-lg border ${
      mapMode === "year"
        ? "bg-black text-white"
        : "bg-white"
    }`}
  >
    Locais do ano
  </button>

  <button
    onClick={() => setMapMode("journey")}
    className={`px-4 py-2 rounded-lg border ${
      mapMode === "journey"
        ? "bg-black text-white"
        : "bg-white"
    }`}
  >
    Trajetória dos santos vivos
  </button>
</div>

        <MapView locations={locations} />

        <p className="text-sm text-gray-500 mt-2">
          Locais exibidos no mapa: {locations.length}
        </p>
      </section>

      <div className="grid md:grid-cols-3 gap-6">
        <div className="bg-[#fffaf0] border border-[#c9b895] rounded-2xl p-6 shadow-sm">
          <h2 className="text-2xl font-bold mb-4">
            Papa
          </h2>

          {popes.length === 0 && (
            <p>Nenhum Papa encontrado.</p>
          )}

          {popes.map((pope) => (
            <div key={pope.id}>
              <h3 className="font-semibold">
                {pope.name}
              </h3>

              <p className="text-sm text-gray-500">
                {pope.start_year} - {pope.end_year}
              </p>

              <p className="mt-2 text-sm">
                {pope.description}
              </p>
            </div>
          ))}
        </div>

        <div className="bg-[#fffaf0] border border-[#c9b895] rounded-2xl p-6 shadow-sm">
          <h2 className="text-2xl font-bold mb-4">
            Santos Vivos
          </h2>

          <div className="space-y-3">
            {saints.map((saint) => (
              <div
                key={saint.id}
                className="border-b pb-2"
              >
                <Link
                  href={`/saints/${saint.id}`}
                  className="font-semibold text-blue-600 hover:underline"
                >
                  {saint.name}
                </Link>

                <p className="text-sm text-gray-500">
                  {saint.birth_year} - {saint.death_year}
                </p>

                <p className="text-sm">
                  {saint.short_description}
                </p>
              </div>
            ))}
          </div>
        </div>

        <div className="bg-[#fffaf0] border border-[#c9b895] rounded-2xl p-6 shadow-sm">
          <h2 className="text-2xl font-bold mb-4">
            Eventos Históricos
          </h2>

          <div className="space-y-3">
            {events.map((event) => (
              <div
                key={event.id}
                className="border-b pb-2"
              >
                <h3 className="font-semibold">
                  {event.year} — {event.title}
                </h3>

                <p className="text-sm text-gray-600">
                  {event.description}
                </p>
              </div>
            ))}
          </div>
        </div>
      </div>
    </main>
  );
}