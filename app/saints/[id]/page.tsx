import Link from "next/link";
import { notFound } from "next/navigation";
import SaintLocationsMap from "@/app/components/SaintLocationsMap";
import { getSaintProfile, parsePositiveId } from "@/lib/data";
import {
  formatYear,
  formatYearRange,
  formatYearRangeShort,
} from "@/lib/formatYear";

export default async function SaintPage({
  params,
}: {
  params: Promise<{ id: string }>;
}) {
  const { id } = await params;
  const numericId = parsePositiveId(id);

  if (!numericId) {
    notFound();
  }

  const profile = await getSaintProfile(numericId);

  if (!profile) {
    notFound();
  }

  const { saint, popes, events, contemporaries, locations } = profile;

  return (
    <main className="min-h-screen max-w-7xl mx-auto p-8">
      <Link href="/santos" className="text-[#8b5e24] hover:underline">
        Voltar para Santos
      </Link>

      <section className="mt-6 mb-10">
        <p className="mb-3 text-sm uppercase tracking-[0.3em] text-[#8b5e24]">
          Perfil do santo
        </p>

        <h1 className="mb-3 text-5xl font-bold text-[#2b1b10] md:text-6xl">
          {saint.name}
        </h1>

        <p className="text-xl text-[#4b3a2a]">
          {formatYearRange(
            saint.birth_year,
            saint.death_year,
            saint.birth_year_note,
            saint.death_year_note
          )}
        </p>

        {saint.famous_quote && (
          <blockquote className="mt-6 border-l-4 border-[#8b5e24] pl-5 text-xl italic text-[#4b3a2a]">
            “{saint.famous_quote}”
          </blockquote>
        )}
      </section>

      <section className="mb-8 grid gap-6 lg:grid-cols-3">
        <Card className="lg:col-span-2">
          <h2 className="mb-4 text-2xl font-bold text-[#2b1b10]">
            Informações gerais
          </h2>

          <div className="grid gap-4 text-[#4b3a2a] md:grid-cols-2">
            <Info label="Nascimento" value={saint.birth_place} />
            <Info label="Falecimento" value={saint.death_place} />
            <Info label="Festa litúrgica" value={saint.feast_day} />
            <Info
              label="Canonização"
              value={
                saint.canonization_year
                  ? `${saint.canonization_year} d.C.`
                  : saint.canonization_note
              }
            />
            <Info label="Ordem religiosa" value={saint.religious_order} />
            <Info label="Categoria" value={saint.category} />
            <Info
              className="md:col-span-2"
              label="Padroeiro de"
              value={saint.patron_of}
            />
          </div>
        </Card>

        <div className="rounded-2xl bg-[#2b1b10] p-6 text-[#fffaf0] shadow-sm">
          <h2 className="mb-4 text-2xl font-bold">Resumo</h2>
          <p className="leading-relaxed">
            {saint.short_description || "Resumo ainda não cadastrado."}
          </p>
        </div>
      </section>

      <Card className="mb-8">
        <h2 className="mb-4 text-3xl font-bold text-[#2b1b10]">Biografia</h2>
        <p className="leading-relaxed text-[#4b3a2a]">
          {saint.biography || "Biografia ainda não cadastrada."}
        </p>
      </Card>

      <section className="mb-8 grid gap-6 lg:grid-cols-2">
        <Card>
          <h2 className="mb-4 text-2xl font-bold text-[#2b1b10]">
            Importância histórica
          </h2>
          <p className="leading-relaxed text-[#4b3a2a]">
            {saint.historical_importance ||
              "Importância histórica ainda não cadastrada."}
          </p>
        </Card>

        <Card>
          <h2 className="mb-4 text-2xl font-bold text-[#2b1b10]">Fontes</h2>
          {saint.sources ? (
            <p className="whitespace-pre-line break-words text-sm leading-relaxed text-[#4b3a2a]">
              {saint.sources}
            </p>
          ) : (
            <p className="text-[#4b3a2a]">Fontes ainda não cadastradas.</p>
          )}
        </Card>
      </section>

      <section className="mb-8 grid gap-6 lg:grid-cols-2">
        <Card>
          <h2 className="mb-4 text-2xl font-bold text-[#2b1b10]">
            Papas contemporâneos
          </h2>

          {popes.length ? (
            <div className="space-y-3">
              {popes.map((pope) => (
                <LinkedItem
                  key={pope.id}
                  href={`/papas/${pope.id}`}
                  title={pope.name}
                  meta={formatYearRange(pope.start_year, pope.end_year)}
                  description={pope.description}
                />
              ))}
            </div>
          ) : (
            <Empty>Nenhum papa cadastrado para este período.</Empty>
          )}
        </Card>

        <Card>
          <h2 className="mb-4 text-2xl font-bold text-[#2b1b10]">
            Eventos históricos durante sua vida
          </h2>

          {events.length ? (
            <div className="space-y-3">
              {events.map((event) => (
                <LinkedItem
                  key={event.id}
                  href={`/eventos/${event.id}`}
                  title={`${formatYear(event.year)} - ${event.title}`}
                  meta={event.category}
                  description={event.description}
                />
              ))}
            </div>
          ) : (
            <Empty>Nenhum evento cadastrado para este período.</Empty>
          )}
        </Card>
      </section>

      <section className="grid gap-6 lg:grid-cols-2">
        <Card>
          <h2 className="mb-4 text-2xl font-bold text-[#2b1b10]">
            Santos contemporâneos
          </h2>

          {contemporaries.length ? (
            <div className="space-y-3">
              {contemporaries.map((other) => (
                <LinkedItem
                  key={other.id}
                  href={`/saints/${other.id}`}
                  title={other.name}
                  meta={formatYearRangeShort(other.birth_year, other.death_year)}
                  description={other.short_description}
                />
              ))}
            </div>
          ) : (
            <Empty>Nenhum santo contemporâneo encontrado.</Empty>
          )}
        </Card>

        <Card>
          <h2 className="mb-4 text-2xl font-bold text-[#2b1b10]">
            Lugares relacionados
          </h2>

          {locations.length ? (
            <div className="space-y-3">
              {locations.map((location) => (
                <LinkedItem
                  key={location.id}
                  href={`/locais/${location.id}`}
                  title={location.location_name}
                  meta={formatYearRange(location.start_year, location.end_year)}
                  description={location.description}
                />
              ))}
            </div>
          ) : (
            <Empty>Nenhum local cadastrado para este santo.</Empty>
          )}
        </Card>
      </section>

      <section className="mt-8">
        <SaintLocationsMap locations={locations} />
      </section>
    </main>
  );
}

function Card({
  children,
  className = "",
}: {
  children: React.ReactNode;
  className?: string;
}) {
  return (
    <div
      className={`rounded-2xl border border-[#c9b895] bg-[#fffaf0] p-6 shadow-sm ${className}`}
    >
      {children}
    </div>
  );
}

function Info({
  className = "",
  label,
  value,
}: {
  className?: string;
  label: string;
  value?: string | null;
}) {
  return (
    <p className={className}>
      <strong>{label}:</strong>
      <br />
      {value || "Não cadastrado"}
    </p>
  );
}

function LinkedItem({
  description,
  href,
  meta,
  title,
}: {
  description?: string | null;
  href: string;
  meta?: string | null;
  title: string;
}) {
  return (
    <Link
      href={href}
      className="block border-b border-[#c9b895] pb-3 hover:text-[#8b5e24]"
    >
      <h3 className="font-bold text-[#2b1b10]">{title}</h3>
      {meta && <p className="text-sm text-[#6b543d]">{meta}</p>}
      {description && (
        <p className="mt-1 text-sm text-[#4b3a2a]">{description}</p>
      )}
    </Link>
  );
}

function Empty({ children }: { children: React.ReactNode }) {
  return <p className="text-[#4b3a2a]">{children}</p>;
}
