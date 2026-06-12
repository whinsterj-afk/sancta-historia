import Link from "next/link";
import SaintLocationsMap from "@/app/components/SaintLocationsMap";
import { getLocations } from "@/lib/data";
import { formatYearRange } from "@/lib/formatYear";

export default async function LocaisPage() {
  const locations = await getLocations();

  return (
    <main className="min-h-screen max-w-7xl mx-auto p-8">
      <section className="mb-8">
        <h1 className="mb-2 text-5xl font-bold text-[#2b1b10]">Locais</h1>
        <p className="max-w-3xl text-lg text-[#4b3a2a]">
          Explore os lugares associados às vidas, missões e mortes dos santos.
        </p>
      </section>

      <section className="mb-8">
        <SaintLocationsMap locations={locations} />
      </section>

      <div className="grid gap-5 md:grid-cols-2 lg:grid-cols-3">
        {locations.map((location) => (
          <Link
            key={location.id}
            href={`/locais/${location.id}`}
            className="rounded-2xl border border-[#c9b895] bg-[#fffaf0] p-5 shadow-sm transition hover:-translate-y-0.5 hover:shadow-md"
          >
            <h2 className="text-xl font-bold text-[#2b1b10]">
              {location.location_name}
            </h2>
            {location.saints?.name && (
              <p className="mt-1 text-sm font-semibold text-[#8b5e24]">
                {location.saints.name}
              </p>
            )}
            <p className="mt-1 text-sm text-[#6b543d]">
              {formatYearRange(location.start_year, location.end_year)}
            </p>
            {location.description && (
              <p className="mt-3 text-sm text-[#4b3a2a]">
                {location.description}
              </p>
            )}
          </Link>
        ))}
      </div>
    </main>
  );
}
