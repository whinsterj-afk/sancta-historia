import Link from "next/link";
import { notFound } from "next/navigation";
import { getPopeProfile, parsePositiveId } from "@/lib/data";
import { formatYear, formatYearRange, formatYearRangeShort } from "@/lib/formatYear";

export default async function PopePage({
  params,
}: {
  params: Promise<{ id: string }>;
}) {
  const { id } = await params;
  const numericId = parsePositiveId(id);

  if (!numericId) {
    notFound();
  }

  const profile = await getPopeProfile(numericId);

  if (!profile) {
    notFound();
  }

  const { pope, saints, events } = profile;

  return (
    <main className="min-h-screen max-w-7xl mx-auto p-8">
      <Link href="/papas" className="text-[#8b5e24] hover:underline">
        Voltar para Papas
      </Link>

      <section className="mt-6 mb-8">
        <p className="mb-3 text-sm uppercase tracking-[0.3em] text-[#8b5e24]">
          Pontificado
        </p>
        <h1 className="mb-3 text-5xl font-bold text-[#2b1b10]">{pope.name}</h1>
        <p className="text-xl text-[#4b3a2a]">
          {formatYearRange(pope.start_year, pope.end_year)}
        </p>
        {pope.nationality && (
          <p className="mt-2 text-sm uppercase tracking-wide text-[#8b5e24]">
            {pope.nationality}
          </p>
        )}
      </section>

      <section className="mb-8 rounded-2xl border border-[#c9b895] bg-[#fffaf0] p-6 shadow-sm">
        <h2 className="mb-4 text-2xl font-bold text-[#2b1b10]">Contexto</h2>
        <p className="leading-relaxed text-[#4b3a2a]">
          {pope.description || "Descrição ainda não cadastrada."}
        </p>
      </section>

      <section className="grid gap-6 lg:grid-cols-2">
        <Panel title="Santos contemporâneos">
          {saints.length ? (
            saints.map((saint) => (
              <Link
                key={saint.id}
                href={`/saints/${saint.id}`}
                className="block border-b border-[#c9b895] pb-3 hover:text-[#8b5e24]"
              >
                <h3 className="font-bold text-[#2b1b10]">{saint.name}</h3>
                <p className="text-sm text-[#6b543d]">
                  {formatYearRangeShort(saint.birth_year, saint.death_year)}
                </p>
                {saint.short_description && (
                  <p className="mt-1 text-sm text-[#4b3a2a]">
                    {saint.short_description}
                  </p>
                )}
              </Link>
            ))
          ) : (
            <p>Nenhum santo encontrado para este pontificado.</p>
          )}
        </Panel>

        <Panel title="Eventos do período">
          {events.length ? (
            events.map((event) => (
              <Link
                key={event.id}
                href={`/eventos/${event.id}`}
                className="block border-b border-[#c9b895] pb-3 hover:text-[#8b5e24]"
              >
                <h3 className="font-bold text-[#2b1b10]">
                  {formatYear(event.year)} - {event.title}
                </h3>
                {event.category && (
                  <p className="text-xs uppercase tracking-wide text-[#8b5e24]">
                    {event.category}
                  </p>
                )}
                {event.description && (
                  <p className="mt-1 text-sm text-[#4b3a2a]">
                    {event.description}
                  </p>
                )}
              </Link>
            ))
          ) : (
            <p>Nenhum evento encontrado para este pontificado.</p>
          )}
        </Panel>
      </section>
    </main>
  );
}

function Panel({
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
