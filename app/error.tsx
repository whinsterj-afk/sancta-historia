"use client";

export default function ErrorPage({
  error,
  unstable_retry,
}: {
  error: Error & { digest?: string };
  unstable_retry: () => void;
}) {
  return (
    <main className="min-h-screen max-w-5xl mx-auto p-8">
      <h1 className="text-3xl font-bold text-[#2b1b10]">
        Não foi possível carregar esta página
      </h1>

      <p className="mt-3 text-[#4b3a2a]">
        {error.message || "Ocorreu um erro inesperado."}
      </p>

      <button
        type="button"
        onClick={() => unstable_retry()}
        className="mt-6 rounded-lg bg-[#2b1b10] px-4 py-2 text-[#fffaf0] transition hover:bg-[#5f3b16]"
      >
        Tentar novamente
      </button>
    </main>
  );
}
