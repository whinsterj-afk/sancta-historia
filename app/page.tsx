import { supabase } from "@/lib/supabase";

export default async function Home() {
  const { data: saints } = await supabase
    .from("saints")
    .select("*")
    .order("birth_year");

  return (
    <main className="min-h-screen bg-stone-50">
      <section className="max-w-6xl mx-auto px-8 py-16">

        <h1 className="text-6xl font-bold mb-4">
          Sancta Historia
        </h1>

        <p className="text-xl text-gray-600 mb-10">
          Explore 2.000 anos de história da Igreja Católica através
          de santos, eventos históricos e mapas interativos.
        </p>

        <div className="grid md:grid-cols-3 gap-6 mb-12">

          <div className="bg-white p-6 rounded-2xl border">
            <h2 className="text-3xl font-bold">
              {saints?.length || 0}
            </h2>
            <p>Santos cadastrados</p>
          </div>

          <div className="bg-white p-6 rounded-2xl border">
            <h2 className="text-3xl font-bold">
              10
            </h2>
            <p>Localizações históricas</p>
          </div>

          <div className="bg-white p-6 rounded-2xl border">
            <h2 className="text-3xl font-bold">
              10
            </h2>
            <p>Eventos históricos</p>
          </div>

        </div>

        <h2 className="text-3xl font-bold mb-6">
          Santos cadastrados
        </h2>

        <div className="grid md:grid-cols-2 gap-4">

          {saints?.map((saint) => (
            <div
              key={saint.id}
              className="bg-white border rounded-xl p-5"
            >
              <h3 className="text-xl font-semibold">
                {saint.name}
              </h3>

              <p className="text-gray-500">
                {saint.birth_year} — {saint.death_year}
              </p>

              <p className="mt-2">
                {saint.short_description}
              </p>
            </div>
          ))}

        </div>

      </section>
    </main>
  );
}