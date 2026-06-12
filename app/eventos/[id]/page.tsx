import Link from "next/link";
import { notFound } from "next/navigation";
import { getHistoricalEventProfile, parsePositiveId } from "@/lib/data";
import { formatYear, formatYearRange, formatYearRangeShort } from "@/lib/formatYear";

export default async function EventoPage({
  params,
}: {
  params: Promise<{ id: string }>;
}) {
  const { id } = await params;
  const numericId = parsePositiveId(id);

  if (!numericId) {
    notFound();
  }

  const profile = await getHistoricalEventProfile(numericId);

  if (!profile) {
    notFound();
  }

  const { event, popes, saints } = profile;

  return (
    <main className="min-h-screen max-w-7xl mx-auto p-8">
      <Link href="/eventos" className="text-[#8b5e24] hover:underline">
        Voltar para Eventos
      </Link>

      <section className="mt-6 mb-8">
        <p className="mb-3 text-sm uppercase tracking-[0.3em] text-[#8b5e24]">
          Evento histórico
        </p>
        <h1 className="mb-3 text-5xl font-bold text-[#2b1b10]">
          {event.title}
        </h1>
        <p className="text-xl text-[#4b3a2a]">{formatYear(event.year)}</p>
        {event.category && (
          <p className="mt-2 text-sm uppercase tracking-wide text-[#8b5e24]">
            {event.category}
          </p>
        )}
      </section>

      <section className="mb-8 rounded-2xl border border-[#c9b895] bg-[#fffaf0] p-6 shadow-sm">
        <h2 className="mb-4 text-2xl font-bold text-[#2b1b10]">Descrição</h2>
        <p className="leading-relaxed text-[#4b3a2a]">
          {event.description || "Descrição ainda não cadastrada."}
        </p>
      </section>

      <section className="grid gap-6 lg:grid-cols-2">
        <Panel title="Papa no período">
          {popes.length ? (
            popes.map((pope) => (
              <Link
                key={pope.id}
                href={`/papas/${pope.id}`}
                className="block border-b border-[#c9b895] pb-3 hover:text-[#8b5e24]"
              >
                <h3 className="font-bold text-[#2b1b10]">{pope.name}</h3>
                <p className="text-sm text-[#6b543d]">
                  {formatYearRange(pope.start_year, pope.end_year)}
                </p>
                {pope.description && (
                  <p className="mt-1 text-sm text-[#4b3a2a]">
                    {pope.description}
                  </p>
                )}
              </Link>
            ))
          ) : (
            <p>Nenhum papa encontrado para este ano.</p>
          )}
        </Panel>

        <Panel title="Santos vivos no ano">
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
            <p>Nenhum santo encontrado para este ano.</p>
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
