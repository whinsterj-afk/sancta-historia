import Link from "next/link";
import { supabase } from "@/lib/supabase";

function formatYear(year: number | null, note?: string | null) {
  if (note) {
    return note;
  }

  if (year === null || year === undefined) {
    return "Não confirmado";
  }

  if (year < 0) {
    return `${Math.abs(year)} a.C.`;
  }

  return `${year} d.C.`;
}

export default async function SaintPage({
  params,
}: {
  params: Promise<{ id: string }>;
}) {
  const { id } = await params;

  const { data: saint } = await supabase
    .from("saints")
    .select("*")
    .eq("id", id)
    .single();

  if (!saint) {
    return (
      <main className="min-h-screen max-w-5xl mx-auto p-8">
        <h1 className="text-3xl font-bold text-[#2b1b10]">
          Santo não encontrado
        </h1>

        <Link
          href="/santos"
          className="inline-block mt-4 text-[#8b5e24] hover:underline"
        >
          ← Voltar para Santos
        </Link>
      </main>
    );
  }

  const { data: popes } = await supabase
    .from("popes")
    .select("*")
    .lte("start_year", saint.death_year)
    .gte("end_year", saint.birth_year)
    .order("start_year");

  const { data: events } = await supabase
    .from("historical_events")
    .select("*")
    .gte("year", saint.birth_year)
    .lte("year", saint.death_year)
    .order("year");

  const { data: contemporaries } = await supabase
    .from("saints")
    .select("*")
    .neq("id", saint.id)
    .lte("birth_year", saint.death_year)
    .gte("death_year", saint.birth_year)
    .order("birth_year")
    .limit(12);

  const { data: locations } = await supabase
    .from("locations")
    .select("*")
    .eq("saint_id", saint.id)
    .order("start_year");

  return (
    <main className="min-h-screen max-w-7xl mx-auto p-8">
      <Link
        href="/santos"
        className="text-[#8b5e24] hover:underline"
      >
        ← Voltar para Santos
      </Link>

      <section className="mt-6 mb-10">
        <p className="text-sm uppercase tracking-[0.3em] text-[#8b5e24] mb-3">
          Perfil do Santo
        </p>

        <h1 className="text-5xl md:text-6xl font-bold text-[#2b1b10] mb-3">
          {saint.name}
        </h1>

        <p className="text-xl text-[#4b3a2a]">
  {formatYear(saint.birth_year, saint.birth_year_note)} —{" "}
  {formatYear(saint.death_year, saint.death_year_note)}
</p>

        {saint.famous_quote && (
          <blockquote className="mt-6 border-l-4 border-[#8b5e24] pl-5 text-xl italic text-[#4b3a2a]">
            “{saint.famous_quote}”
          </blockquote>
        )}
      </section>

      <section className="grid lg:grid-cols-3 gap-6 mb-8">
        <div className="lg:col-span-2 bg-[#fffaf0] border border-[#c9b895] rounded-2xl p-6 shadow-sm">
          <h2 className="text-2xl font-bold mb-4 text-[#2b1b10]">
            Informações Gerais
          </h2>

          <div className="grid md:grid-cols-2 gap-4 text-[#4b3a2a]">
            <p>
              <strong>Nascimento:</strong>
              <br />
              {saint.birth_place || "Não cadastrado"}
            </p>

            <p>
              <strong>Falecimento:</strong>
              <br />
              {saint.death_place || "Não cadastrado"}
            </p>

            <p>
              <strong>Festa litúrgica:</strong>
              <br />
              {saint.feast_day || "Não cadastrada"}
            </p>

            <p>
  <strong>Canonização:</strong>
  <br />
  {saint.canonization_year
    ? `${saint.canonization_year} d.C.`
    : saint.canonization_note || "Não cadastrada"}
</p>

            <p>
              <strong>Ordem religiosa:</strong>
              <br />
              {saint.religious_order || "Não cadastrada"}
            </p>

            <p>
              <strong>Categoria:</strong>
              <br />
              {saint.category || "Não cadastrada"}
            </p>

            <p className="md:col-span-2">
              <strong>Padroeiro de:</strong>
              <br />
              {saint.patron_of || "Não cadastrado"}
            </p>
          </div>
        </div>

        <div className="bg-[#2b1b10] text-[#fffaf0] rounded-2xl p-6 shadow-sm">
          <h2 className="text-2xl font-bold mb-4">
            Resumo
          </h2>

          <p className="leading-relaxed">
            {saint.short_description || "Resumo ainda não cadastrado."}
          </p>
        </div>
      </section>

      <section className="bg-[#fffaf0] border border-[#c9b895] rounded-2xl p-6 shadow-sm mb-8">
        <h2 className="text-3xl font-bold mb-4 text-[#2b1b10]">
          Biografia
        </h2>

        <p className="text-[#4b3a2a] leading-relaxed">
          {saint.biography || "Biografia ainda não cadastrada."}
        </p>
      </section>

      <section className="grid lg:grid-cols-2 gap-6 mb-8">
  <div className="bg-[#fffaf0] border border-[#c9b895] rounded-2xl p-6 shadow-sm">
    <h2 className="text-2xl font-bold mb-4 text-[#2b1b10]">
      Importância histórica
    </h2>

    <p className="text-[#4b3a2a] leading-relaxed">
      {saint.historical_importance ||
        "Importância histórica ainda não cadastrada."}
    </p>
  </div>

  <div className="bg-[#fffaf0] border border-[#c9b895] rounded-2xl p-6 shadow-sm">
    <h2 className="text-2xl font-bold mb-4 text-[#2b1b10]">
      Fontes
    </h2>

    {saint.sources ? (
      <p className="text-sm text-[#4b3a2a] leading-relaxed whitespace-pre-line break-words">
        {saint.sources}
      </p>
    ) : (
      <p className="text-[#4b3a2a]">
        Fontes ainda não cadastradas.
      </p>
    )}
  </div>
</section>

      <section className="grid lg:grid-cols-2 gap-6 mb-8">
        <div className="bg-[#fffaf0] border border-[#c9b895] rounded-2xl p-6 shadow-sm">
          <h2 className="text-2xl font-bold mb-4 text-[#2b1b10]">
            Papas contemporâneos
          </h2>

          {popes?.length ? (
            <div className="space-y-3">
              {popes.map((pope) => (
                <div key={pope.id} className="border-b border-[#c9b895] pb-3">
                  <h3 className="font-bold text-[#2b1b10]">
                    {pope.name}
                  </h3>

                  <p className="text-sm text-[#6b543d]">
                    {pope.start_year} — {pope.end_year}
                  </p>

                  <p className="text-sm text-[#4b3a2a] mt-1">
                    {pope.description}
                  </p>
                </div>
              ))}
            </div>
          ) : (
            <p className="text-[#4b3a2a]">
              Nenhum papa cadastrado para este período.
            </p>
          )}
        </div>

        <div className="bg-[#fffaf0] border border-[#c9b895] rounded-2xl p-6 shadow-sm">
          <h2 className="text-2xl font-bold mb-4 text-[#2b1b10]">
            Eventos históricos durante sua vida
          </h2>

          {events?.length ? (
            <div className="space-y-3">
              {events.map((event) => (
                <div key={event.id} className="border-b border-[#c9b895] pb-3">
                  <h3 className="font-bold text-[#2b1b10]">
                    {event.year} — {event.title}
                  </h3>

                  {event.category && (
                    <p className="text-xs uppercase tracking-wide text-[#8b5e24]">
                      {event.category}
                    </p>
                  )}

                  <p className="text-sm text-[#4b3a2a] mt-1">
                    {event.description}
                  </p>
                </div>
              ))}
            </div>
          ) : (
            <p className="text-[#4b3a2a]">
              Nenhum evento cadastrado para este período.
            </p>
          )}
        </div>
      </section>

      <section className="grid lg:grid-cols-2 gap-6">
        <div className="bg-[#fffaf0] border border-[#c9b895] rounded-2xl p-6 shadow-sm">
          <h2 className="text-2xl font-bold mb-4 text-[#2b1b10]">
            Santos contemporâneos
          </h2>

          {contemporaries?.length ? (
            <div className="space-y-3">
              {contemporaries.map((other) => (
                <Link
                  key={other.id}
                  href={`/saints/${other.id}`}
                  className="block border-b border-[#c9b895] pb-3 hover:text-[#8b5e24]"
                >
                  <h3 className="font-bold">
                    {other.name}
                  </h3>

                  <p className="text-sm text-[#6b543d]">
                    {other.birth_year} — {other.death_year}
                  </p>

                  <p className="text-sm text-[#4b3a2a]">
                    {other.short_description}
                  </p>
                </Link>
              ))}
            </div>
          ) : (
            <p className="text-[#4b3a2a]">
              Nenhum santo contemporâneo encontrado.
            </p>
          )}
        </div>

        <div className="bg-[#fffaf0] border border-[#c9b895] rounded-2xl p-6 shadow-sm">
          <h2 className="text-2xl font-bold mb-4 text-[#2b1b10]">
            Lugares relacionados
          </h2>

          {locations?.length ? (
            <div className="space-y-3">
              {locations.map((location) => (
                <div key={location.id} className="border-b border-[#c9b895] pb-3">
                  <h3 className="font-bold text-[#2b1b10]">
                    {location.location_name}
                  </h3>

                  <p className="text-sm text-[#6b543d]">
                    {location.start_year} — {location.end_year}
                  </p>

                  <p className="text-sm text-[#4b3a2a] mt-1">
                    {location.description}
                  </p>
                </div>
              ))}
            </div>
          ) : (
            <p className="text-[#4b3a2a]">
              Nenhum local cadastrado para este santo.
            </p>
          )}
        </div>
      </section>
    </main>
  );
}