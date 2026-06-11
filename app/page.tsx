"use client";

import { useEffect, useState } from "react";
import { supabase } from "@/lib/supabase";

export default function Home() {
  const [year, setYear] = useState(1220);
  const [saints, setSaints] = useState<any[]>([]);

  useEffect(() => {
    loadSaints();
  }, [year]);

  async function loadSaints() {
    const { data } = await supabase
      .from("saints")
      .select("*")
      .lte("birth_year", year)
      .gte("death_year", year)
      .order("birth_year");

    setSaints(data || []);
  }

  return (
    <main className="max-w-6xl mx-auto p-10">

      <h1 className="text-5xl font-bold mb-6">
        Sancta Historia
      </h1>

      <h2 className="text-2xl mb-4">
        Ano Selecionado: {year}
      </h2>

      <input
        type="range"
        min="1"
        max="2025"
        value={year}
        onChange={(e) => setYear(Number(e.target.value))}
        className="w-full mb-8"
      />

      <div className="grid gap-4">

        {saints.map((saint) => (
          <div
            key={saint.id}
            className="border rounded-xl p-4 bg-white"
          >
            <h3 className="font-bold text-xl">
              {saint.name}
            </h3>

            <p>
              {saint.birth_year} - {saint.death_year}
            </p>

            <p>
              {saint.short_description}
            </p>
          </div>
        ))}

      </div>

    </main>
  );
}