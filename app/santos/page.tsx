"use client";

import { useEffect, useMemo, useState } from "react";
import Link from "next/link";
import { supabase } from "@/lib/supabase";

type Saint = {
  id: number;
  name: string;
  birth_year: number;
  death_year: number;
  birth_place: string;
  death_place: string;
  short_description: string;
};

export default function SantosPage() {
  const [saints, setSaints] = useState<Saint[]>([]);
  const [search, setSearch] = useState("");

  useEffect(() => {
    loadSaints();
  }, []);

  async function loadSaints() {
    const { data } = await supabase
      .from("saints")
      .select("*")
      .order("birth_year", { ascending: true });

    setSaints(data || []);
  }

  const filteredSaints = useMemo(() => {
    return saints.filter((saint) =>
      saint.name.toLowerCase().includes(search.toLowerCase())
    );
  }, [saints, search]);

  return (
    <main className="min-h-screen max-w-7xl mx-auto p-8">
      <h1 className="text-5xl font-bold mb-2 text-[#2b1b10]">
        Santos
      </h1>

      <p className="text-lg text-[#4b3a2a] mb-8">
        Consulte os santos cadastrados no Sancta Historia e acesse suas páginas individuais.
      </p>

      <div className="mb-8">
        <input
          type="text"
          placeholder="Buscar santo pelo nome..."
          value={search}
          onChange={(e) => setSearch(e.target.value)}
          className="w-full md:w-96 border border-[#c9b895] rounded-xl px-4 py-3 bg-[#fffaf0]"
        />
      </div>

      <p className="mb-4 text-sm text-[#4b3a2a]">
        Exibindo {filteredSaints.length} de {saints.length} santos cadastrados.
      </p>

      <div className="grid md:grid-cols-2 lg:grid-cols-3 gap-5">
        {filteredSaints.map((saint) => (
          <Link
            key={saint.id}
            href={`/saints/${saint.id}`}
            className="bg-[#fffaf0] border border-[#c9b895] rounded-2xl p-5 shadow-sm hover:shadow-md transition"
          >
            <h2 className="text-xl font-bold text-[#2b1b10]">
              {saint.name}
            </h2>

            <p className="text-sm text-[#6b543d] mt-1">
              {saint.birth_year} — {saint.death_year}
            </p>

            <p className="text-sm mt-3 text-[#4b3a2a]">
              {saint.short_description}
            </p>

            <div className="mt-4 text-sm text-[#6b543d]">
              <p>
                <strong>Nascimento:</strong> {saint.birth_place}
              </p>

              <p>
                <strong>Falecimento:</strong> {saint.death_place}
              </p>
            </div>
          </Link>
        ))}
      </div>
    </main>
  );
}