import Link from "next/link";
import { notFound } from "next/navigation";
import SaintLocationsMap from "@/app/components/SaintLocationsMap";
import { getLocationProfile, parsePositiveId } from "@/lib/data";
import { formatYearRange } from "@/lib/formatYear";

export default async function LocalPage({
  params,
}: {
  params: Promise<{ id: string }>;
}) {
  const { id } = await params;
  const numericId = parsePositiveId(id);

  if (!numericId) {
    notFound();
  }

  const profile = await getLocationProfile(numericId);

  if (!profile) {
    notFound();
  }

  const { location, relatedLocations } = profile;
  const mapLocations = [location, ...relatedLocations];

  return (
    <main className="min-h-screen max-w-7xl mx-auto p-8">
      <Link href="/locais" className="text-[#8b5e24] hover:underline">
        Voltar para Locais
      </Link>

      <section className="mt-6 mb-8">
        <p className="mb-3 text-sm uppercase tracking-[0.3em] text-[#8b5e24]">
          Local histórico
        </p>
        <h1 className="mb-3 text-5xl font-bold text-[#2b1b10]">
          {location.location_name}
        </h1>
        {location.saints?.name && (
          <Link
            href={`/saints/${location.saints.id}`}
            className="text-lg font-semibold text-[#8b5e24] hover:underline"
          >
            {location.saints.name}
          </Link>
        )}
        <p className="mt-2 text-xl text-[#4b3a2a]">
          {formatYearRange(location.start_year, location.end_year)}
        </p>
      </section>

      <section className="mb-8 rounded-2xl border border-[#c9b895] bg-[#fffaf0] p-6 shadow-sm">
        <h2 className="mb-4 text-2xl font-bold text-[#2b1b10]">Descrição</h2>
        <p className="leading-relaxed text-[#4b3a2a]">
          {location.description || "Descrição ainda não cadastrada."}
        </p>
      </section>

      <section className="mb-8">
        <SaintLocationsMap locations={mapLocations} />
      </section>

      {relatedLocations.length > 0 && (
        <section className="rounded-2xl border border-[#c9b895] bg-[#fffaf0] p-6 shadow-sm">
          <h2 className="mb-4 text-2xl font-bold text-[#2b1b10]">
            Outros locais relacionados
          </h2>
          <div className="grid gap-4 md:grid-cols-2">
            {relatedLocations.map((item) => (
              <Link
                key={item.id}
                href={`/locais/${item.id}`}
                className="block border-b border-[#c9b895] pb-3 hover:text-[#8b5e24]"
              >
                <h3 className="font-bold text-[#2b1b10]">
                  {item.location_name}
                </h3>
                <p className="text-sm text-[#6b543d]">
                  {formatYearRange(item.start_year, item.end_year)}
                </p>
                {item.description && (
                  <p className="mt-1 text-sm text-[#4b3a2a]">
                    {item.description}
                  </p>
                )}
              </Link>
            ))}
          </div>
        </section>
      )}
    </main>
  );
}
