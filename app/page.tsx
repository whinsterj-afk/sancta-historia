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

  useEffect(() => {
    loadData();
  }, [year]);

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

    const { data: locationData } = await supabase
      .from("locations")
      .select("*, saints(name)")
      .lte("start_year", year)
      .gte("end_year", year);

    setSaints(saintsData || []);
    setPopes(popeData || []);
    setEvents(eventData || []);
    setLocations(locationData || []);
  }

  return (
    <main className="max-w-7xl mx-auto p-8">
      <h1 className="text-5xl font-bold mb-2">
        Sancta Historia
      </h1>

      <p className="text-gray-600 mb-8">
        Explore a história da Igreja Católica através do tempo.
      </p>

      <div className="mb-8">
        <h2 className="text-2xl font-semibold mb-2">
          Ano Selecionado: {year}
        </h2>

        <input
          type="range"
          min="1"
          max="2025"
          value={year}
          onChange={(e) => setYear(Number(e.target.value))}
          className="w-full"
        />
      </div>

      <section className="mb-8">
        <h2 className="text-2xl font-bold mb-4">
          Mapa Histórico
        </h2>

        <MapView locations={locations} />

        <p className="text-sm text-gray-500 mt-2">
          Locais exibidos no mapa: {locations.length}
        </p>
      </section>

      <div className="grid md:grid-cols-3 gap-6">
        <div className="bg-white border rounded-xl p-5">
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

        <div className="bg-white border rounded-xl p-5">
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

        <div className="bg-white border rounded-xl p-5">
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