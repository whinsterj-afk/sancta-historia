import Link from "next/link";
import { getPopes } from "@/lib/data";
import { formatYearRange } from "@/lib/formatYear";

export default async function PapasPage() {
  const popes = await getPopes();

  return (
    <main className="min-h-screen max-w-7xl mx-auto p-8">
      <section className="mb-8">
        <h1 className="mb-2 text-5xl font-bold text-[#2b1b10]">Papas</h1>
        <p className="max-w-3xl text-lg text-[#4b3a2a]">
          Navegue pelos pontificados e veja santos e eventos associados a cada
          período.
        </p>
      </section>

      <div className="grid gap-5 md:grid-cols-2 lg:grid-cols-3">
        {popes.map((pope) => (
          <Link
            key={pope.id}
            href={`/papas/${pope.id}`}
            className="rounded-2xl border border-[#c9b895] bg-[#fffaf0] p-5 shadow-sm transition hover:-translate-y-0.5 hover:shadow-md"
          >
            <h2 className="text-xl font-bold text-[#2b1b10]">{pope.name}</h2>
            <p className="mt-1 text-sm text-[#6b543d]">
              {formatYearRange(pope.start_year, pope.end_year)}
            </p>
            {pope.nationality && (
              <p className="mt-3 text-xs uppercase tracking-wide text-[#8b5e24]">
                {pope.nationality}
              </p>
            )}
            {pope.description && (
              <p className="mt-3 text-sm text-[#4b3a2a]">{pope.description}</p>
            )}
          </Link>
        ))}
      </div>
    </main>
  );
}
