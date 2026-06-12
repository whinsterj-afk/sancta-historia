import Link from "next/link";
import { getSaintCategories, getSaints } from "@/lib/data";
import { formatYearRangeShort } from "@/lib/formatYear";

export default async function SantosPage({
  searchParams,
}: {
  searchParams: Promise<{
    q?: string;
    categoria?: string;
  }>;
}) {
  const params = await searchParams;
  const search = params.q?.trim() || "";
  const category = params.categoria?.trim() || "";

  const [saints, categories] = await Promise.all([
    getSaints({ search, category }),
    getSaintCategories(),
  ]);

  return (
    <main className="min-h-screen max-w-7xl mx-auto p-8">
      <section className="mb-8">
        <h1 className="mb-2 text-5xl font-bold text-[#2b1b10]">Santos</h1>

        <p className="max-w-3xl text-lg text-[#4b3a2a]">
          Consulte os santos cadastrados no Sancta Historia e navegue por suas
          relações históricas, geográficas e espirituais.
        </p>
      </section>

      <form
        action="/santos"
        className="mb-6 grid gap-3 rounded-2xl border border-[#c9b895] bg-[#fffaf0] p-4 shadow-sm md:grid-cols-[1fr_240px_auto]"
      >
        <input
          type="search"
          name="q"
          placeholder="Buscar santo pelo nome..."
          defaultValue={search}
          className="w-full rounded-xl border border-[#c9b895] bg-white px-4 py-3"
        />

        <select
          name="categoria"
          defaultValue={category}
          className="rounded-xl border border-[#c9b895] bg-white px-4 py-3 text-[#4b3a2a]"
        >
          <option value="">Todas as categorias</option>
          {categories.map((item) => (
            <option key={item} value={item}>
              {item}
            </option>
          ))}
        </select>

        <button
          type="submit"
          className="rounded-xl bg-[#2b1b10] px-5 py-3 font-semibold text-[#fffaf0] transition hover:bg-[#5f3b16]"
        >
          Buscar
        </button>
      </form>

      <div className="mb-6 flex flex-wrap gap-2">
        <Link
          href="/santos"
          className={`rounded-full border px-3 py-1 text-sm ${
            !category
              ? "border-[#2b1b10] bg-[#2b1b10] text-[#fffaf0]"
              : "border-[#c9b895] bg-[#fffaf0] text-[#4b3a2a]"
          }`}
        >
          Todas
        </Link>
        {categories.map((item) => {
          const href = search
            ? `/santos?q=${encodeURIComponent(search)}&categoria=${encodeURIComponent(item)}`
            : `/santos?categoria=${encodeURIComponent(item)}`;

          return (
            <Link
              key={item}
              href={href}
              className={`rounded-full border px-3 py-1 text-sm ${
                category === item
                  ? "border-[#2b1b10] bg-[#2b1b10] text-[#fffaf0]"
                  : "border-[#c9b895] bg-[#fffaf0] text-[#4b3a2a] hover:bg-[#eadfcb]"
              }`}
            >
              {item}
            </Link>
          );
        })}
      </div>

      <p className="mb-4 text-sm text-[#4b3a2a]">
        Exibindo {saints.length} santo{saints.length === 1 ? "" : "s"}.
      </p>

      <div className="grid gap-5 md:grid-cols-2 lg:grid-cols-3">
        {saints.map((saint) => (
          <Link
            key={saint.id}
            href={`/saints/${saint.id}`}
            className="rounded-2xl border border-[#c9b895] bg-[#fffaf0] p-5 shadow-sm transition hover:-translate-y-0.5 hover:shadow-md"
          >
            <h2 className="text-xl font-bold text-[#2b1b10]">{saint.name}</h2>

            <p className="mt-1 text-sm text-[#6b543d]">
              {formatYearRangeShort(
                saint.birth_year,
                saint.death_year,
                saint.birth_year_note,
                saint.death_year_note
              )}
            </p>

            {saint.category && (
              <p className="mt-3 text-xs uppercase tracking-wide text-[#8b5e24]">
                {saint.category}
              </p>
            )}

            {saint.short_description && (
              <p className="mt-3 text-sm text-[#4b3a2a]">
                {saint.short_description}
              </p>
            )}

            <div className="mt-4 space-y-1 text-sm text-[#6b543d]">
              <p>
                <strong>Nascimento:</strong> {saint.birth_place || "Não informado"}
              </p>
              <p>
                <strong>Falecimento:</strong>{" "}
                {saint.death_place || "Não informado"}
              </p>
            </div>
          </Link>
        ))}
      </div>
    </main>
  );
}
