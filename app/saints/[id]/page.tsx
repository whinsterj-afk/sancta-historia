import Link from "next/link";
import { supabase } from "@/lib/supabase";
import {
  applyEventEditorial,
  applySaintEditorial,
} from "@/lib/catholicEditorial";
import {
  formatHistoricalPeriod,
  formatHistoricalYear,
  formatLifeSpan,
} from "@/lib/historicalYear";
import { BookIcon, ChevronLeftIcon, InfoIcon, MedalIcon } from "@/components/icons";

function initials(name: string) {
  return name
    .replace(/^(São|Santa|Santo)\s+/i, "")
    .split(" ")
    .slice(0, 2)
    .map((w) => w[0])
    .join("")
    .toUpperCase();
}

export default async function SaintPage({
  params,
}: {
  params: Promise<{ id: string }>;
}) {
  const { id } = await params;

  const { data: saintRecord } = await supabase
    .from("saints_catalog")
    .select("*")
    .eq("id", id)
    .single();

  if (!saintRecord) {
    return (
      <main className="min-h-screen bg-ink-950 text-parchment flex items-center justify-center">
        <div className="text-center">
          <h1 className="font-display text-3xl text-gold-200 tracking-wide">
            Santo não encontrado
          </h1>
          <Link
            href="/"
            className="mt-4 inline-flex items-center gap-1 text-gold-300 hover:text-gold-200 text-sm tracking-[0.1em]"
          >
            <ChevronLeftIcon className="h-4 w-4" />
            VOLTAR PARA TIMELINE
          </Link>
        </div>
      </main>
    );
  }

  const saint = applySaintEditorial(saintRecord);

  const { data: popes } = await supabase
    .from("popes")
    .select("*")
    .lte("start_year", saint.death_year)
    .gte("end_year", saint.birth_year)
    .order("start_year");

  const { data: eventRecords } = await supabase
    .from("historical_events")
    .select("*")
    .gte("year", saint.birth_year)
    .lte("year", saint.death_year)
    .order("year");
  const events = eventRecords?.map(applyEventEditorial);

  const { data: contemporaries } = await supabase
    .from("saints_catalog")
    .select("*")
    .neq("id", saint.id)
    .lte("birth_year", saint.death_year)
    .gte("death_year", saint.birth_year)
    .limit(10);

  const { data: devotion } = await supabase
    .from("saint_devotee_counts")
    .select("devotee_count")
    .eq("saint_id", saint.id)
    .maybeSingle();
  const devoteeCount = devotion?.devotee_count ?? 0;

  return (
    <main className="min-h-screen bg-ink-950 text-parchment">
      <div className="max-w-6xl mx-auto px-6 py-10">
        <Link
          href="/"
          className="inline-flex items-center gap-1 text-gold-300 hover:text-gold-200 transition text-xs tracking-[0.15em]"
        >
          <ChevronLeftIcon className="h-4 w-4" />
          VOLTAR PARA TIMELINE
        </Link>

        <div className="flex items-center gap-5 mt-6">
          <div className="flex h-20 w-20 shrink-0 items-center justify-center rounded-full border-2 border-gold-500/60 bg-ink-800 font-display text-2xl text-gold-300">
            {initials(saint.name)}
          </div>
          <div>
            <h1 className="font-display text-3xl sm:text-4xl tracking-[0.05em] text-gold-200">
              {saint.name}
            </h1>
            <div className="mt-1 flex flex-wrap items-center gap-x-3 gap-y-1">
              <p className="text-lg text-gold-400">
                {formatLifeSpan(saint.birth_year, saint.death_year)}
              </p>
              {devoteeCount > 0 && (
                <span className="rounded-full border border-gold-500/40 px-2.5 py-0.5 text-xs tracking-[0.05em] text-gold-300">
                  {devoteeCount} {devoteeCount === 1 ? "devoto" : "devotos"}
                </span>
              )}
            </div>
          </div>
        </div>

        <div className="mt-10 grid md:grid-cols-2 gap-6">
          <section className="panel-glass border rounded-xl p-6">
            <div className="flex items-center gap-2 mb-4">
              <InfoIcon className="h-4 w-4 text-gold-400" />
              <h2 className="font-display text-sm tracking-[0.15em] text-gold-300">
                INFORMAÇÕES GERAIS
              </h2>
            </div>

            <p className="text-parchment">
              <strong className="text-gold-300 font-semibold">Nascimento:</strong>{" "}
              {saint.birth_place}
            </p>

            <p className="text-parchment mt-1">
              <strong className="text-gold-300 font-semibold">Falecimento:</strong>{" "}
              {saint.death_place}
            </p>

            {saint.short_description && (
              <p className="mt-4 italic text-parchment-dim">{saint.short_description}</p>
            )}

            <div className="mt-6 border-t gold-hairline pt-4">
              <h3 className="font-display text-xs tracking-[0.15em] text-gold-300 mb-2">
                BIOGRAFIA
              </h3>
              <p className="text-parchment-dim leading-relaxed">
                {saint.biography || "Biografia ainda não cadastrada."}
              </p>
            </div>
          </section>

          <section className="panel-glass border rounded-xl p-6">
            <div className="flex items-center gap-2 mb-4">
              <MedalIcon className="h-4 w-4 text-gold-400" />
              <h2 className="font-display text-sm tracking-[0.15em] text-gold-300">
                PAPAS CONTEMPORÂNEOS
              </h2>
            </div>

            {popes?.length ? (
              <div className="space-y-3">
                {popes.map((pope) => (
                  <div key={pope.id} className="border-b gold-hairline last:border-0 pb-3">
                    <strong className="text-parchment">{pope.name}</strong>
                    <p className="text-xs text-gold-400 mt-0.5">
                      {formatHistoricalPeriod(
                        pope.start_year,
                        pope.end_year,
                      )}
                    </p>
                    {pope.description && (
                      <p className="text-sm text-parchment-dim mt-1">{pope.description}</p>
                    )}
                  </div>
                ))}
              </div>
            ) : (
              <p className="text-parchment-dim italic">Nenhum papa encontrado.</p>
            )}
          </section>
        </div>

        <div className="mt-6 grid md:grid-cols-2 gap-6">
          <section className="panel-glass border rounded-xl p-6">
            <div className="flex items-center gap-2 mb-4">
              <BookIcon className="h-4 w-4 text-gold-400" />
              <h2 className="font-display text-sm tracking-[0.15em] text-gold-300">
                EVENTOS HISTÓRICOS
              </h2>
            </div>

            {events?.length ? (
              <div className="space-y-3">
                {events.map((event) => (
                  <div key={event.id} className="border-b gold-hairline last:border-0 pb-3">
                    <strong className="text-parchment">
                      {formatHistoricalYear(event.year)} — {event.title}
                    </strong>
                    {event.description && (
                      <p className="text-sm text-parchment-dim mt-1">{event.description}</p>
                    )}
                  </div>
                ))}
              </div>
            ) : (
              <p className="text-parchment-dim italic">
                Nenhum evento cadastrado para este período.
              </p>
            )}
          </section>

          <section className="panel-glass border rounded-xl p-6">
            <div className="flex items-center gap-2 mb-4">
              <MedalIcon className="h-4 w-4 text-gold-400" />
              <h2 className="font-display text-sm tracking-[0.15em] text-gold-300">
                SANTOS CONTEMPORÂNEOS
              </h2>
            </div>

            {contemporaries?.length ? (
              <div className="space-y-3">
                {contemporaries.map((other) => (
                  <Link
                    key={other.id}
                    href={`/saints/${other.id}`}
                    className="block border-b gold-hairline last:border-0 pb-3 group"
                  >
                    <strong className="text-parchment group-hover:text-gold-300 transition">
                      {other.name}
                    </strong>
                    <p className="text-xs text-gold-400 mt-0.5">
                      {formatLifeSpan(other.birth_year, other.death_year)}
                    </p>
                  </Link>
                ))}
              </div>
            ) : (
              <p className="text-parchment-dim italic">
                Nenhum santo contemporâneo encontrado.
              </p>
            )}
          </section>
        </div>
      </div>
    </main>
  );
}
