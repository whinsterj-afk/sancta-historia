import { supabase } from "@/lib/supabase";

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
      <main className="max-w-5xl mx-auto p-8">
        <h1 className="text-3xl font-bold">
          Santo não encontrado
        </h1>
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
    .limit(10);

  return (
    <main className="max-w-6xl mx-auto p-8">

      <a
        href="/"
        className="text-blue-600 hover:underline"
      >
        ← Voltar para Timeline
      </a>

      <h1 className="text-5xl font-bold mt-4">
        {saint.name}
      </h1>

      <p className="text-xl text-gray-600 mt-2">
        {saint.birth_year} — {saint.death_year}
      </p>

      <div className="mt-8 grid md:grid-cols-2 gap-8">

        <div className="border rounded-xl p-6">

          <h2 className="text-2xl font-bold mb-4">
            Informações Gerais
          </h2>

          <p>
            <strong>Nascimento:</strong>{" "}
            {saint.birth_place}
          </p>

          <p>
            <strong>Falecimento:</strong>{" "}
            {saint.death_place}
          </p>

          <p className="mt-4">
            {saint.short_description}
          </p>

          <div className="mt-6">
            <h3 className="text-xl font-bold mb-2">
              Biografia
            </h3>

            <p>
              {saint.biography ||
                "Biografia ainda não cadastrada."}
            </p>
          </div>

        </div>

        <div className="border rounded-xl p-6">

          <h2 className="text-2xl font-bold mb-4">
            Papas Contemporâneos
          </h2>

          {popes?.length ? (
            popes.map((pope) => (
              <div
                key={pope.id}
                className="border-b pb-2 mb-2"
              >
                <strong>{pope.name}</strong>
                <br />
                {pope.start_year} - {pope.end_year}
                <br />
                <span className="text-sm text-gray-600">
                  {pope.description}
                </span>
              </div>
            ))
          ) : (
            <p>Nenhum papa encontrado.</p>
          )}
        </div>

      </div>

      <div className="mt-8 grid md:grid-cols-2 gap-8">

        <div className="border rounded-xl p-6">

          <h2 className="text-2xl font-bold mb-4">
            Eventos Históricos
          </h2>

          {events?.length ? (
            events.map((event) => (
              <div
                key={event.id}
                className="border-b pb-2 mb-2"
              >
                <strong>
                  {event.year} — {event.title}
                </strong>

                <p className="text-sm text-gray-600">
                  {event.description}
                </p>
              </div>
            ))
          ) : (
            <p>
              Nenhum evento cadastrado para este período.
            </p>
          )}

        </div>

        <div className="border rounded-xl p-6">

          <h2 className="text-2xl font-bold mb-4">
            Santos Contemporâneos
          </h2>

          {contemporaries?.length ? (
            contemporaries.map((other) => (
              <div
                key={other.id}
                className="border-b pb-2 mb-2"
              >
                <strong>{other.name}</strong>

                <p className="text-sm text-gray-600">
                  {other.birth_year} - {other.death_year}
                </p>
              </div>
            ))
          ) : (
            <p>
              Nenhum santo contemporâneo encontrado.
            </p>
          )}

        </div>

      </div>

    </main>
  );
}