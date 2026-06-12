import Link from "next/link";

export default function NotFound() {
  return (
    <main className="min-h-screen max-w-5xl mx-auto p-8">
      <h1 className="text-3xl font-bold text-[#2b1b10]">
        Página não encontrada
      </h1>

      <p className="mt-3 text-[#4b3a2a]">
        O conteúdo solicitado não existe ou ainda não foi cadastrado.
      </p>

      <Link
        href="/"
        className="mt-6 inline-block text-[#8b5e24] hover:underline"
      >
        Voltar para a linha do tempo
      </Link>
    </main>
  );
}
