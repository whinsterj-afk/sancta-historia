import Link from "next/link";
import { getEventCategories, getHistoricalEvents } from "@/lib/data";
import { formatYear } from "@/lib/formatYear";

export default async function EventosPage({
  searchParams,
}: {
  searchParams: Promise<{ categoria?: string }>;
}) {
  const { categoria } = await searchParams;
  const category = categoria?.trim() || "";
  const [events, categories] = await Promise.all([
    getHistoricalEvents(category),
    getEventCategories(),
  ]);

  return (
    <main className="min-h-screen max-w-7xl mx-auto p-8">
      <section className="mb-8">
        <h1 className="mb-2 text-5xl font-bold text-[#2b1b10]">
          Eventos históricos
        </h1>
        <p className="max-w-3xl text-lg text-[#4b3a2a]">
          Acompanhe acontecimentos que ajudam a contextualizar a vida dos
          santos e os pontificados.
        </p>
      </section>

      <div className="mb-6 flex flex-wrap gap-2">
        <Link
          href="/eventos"
          className={`rounded-full border px-3 py-1 text-sm ${
            !category
              ? "border-[#2b1b10] bg-[#2b1b10] text-[#fffaf0]"
              : "border-[#c9b895] bg-[#fffaf0] text-[#4b3a2a]"
          }`}
        >
          Todos
        </Link>
        {categories.map((item) => (
          <Link
            key={item}
            href={`/eventos?categoria=${encodeURIComponent(item)}`}
            className={`rounded-full border px-3 py-1 text-sm ${
              category === item
                ? "border-[#2b1b10] bg-[#2b1b10] text-[#fffaf0]"
                : "border-[#c9b895] bg-[#fffaf0] text-[#4b3a2a] hover:bg-[#eadfcb]"
            }`}
          >
            {item}
          </Link>
        ))}
      </div>

      <div className="grid gap-5 md:grid-cols-2 lg:grid-cols-3">
        {events.map((event) => (
          <Link
            key={event.id}
            href={`/eventos/${event.id}`}
            className="rounded-2xl border border-[#c9b895] bg-[#fffaf0] p-5 shadow-sm transition hover:-translate-y-0.5 hover:shadow-md"
          >
            <p className="text-sm font-semibold text-[#8b5e24]">
              {formatYear(event.year)}
            </p>
            <h2 className="mt-1 text-xl font-bold text-[#2b1b10]">
              {event.title}
            </h2>
            {event.category && (
              <p className="mt-3 text-xs uppercase tracking-wide text-[#8b5e24]">
                {event.category}
              </p>
            )}
            {event.description && (
              <p className="mt-3 text-sm text-[#4b3a2a]">{event.description}</p>
            )}
          </Link>
        ))}
      </div>
    </main>
  );
}
