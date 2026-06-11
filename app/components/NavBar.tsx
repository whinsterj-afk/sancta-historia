import Link from "next/link";

export default function NavBar() {
  return (
    <header className="border-b border-[#c9b895] bg-[#fffaf0]/90 backdrop-blur">
      <nav className="max-w-7xl mx-auto px-8 py-4 flex flex-col md:flex-row md:items-center md:justify-between gap-4">
        <Link
          href="/"
          className="text-2xl font-bold text-[#2b1b10]"
        >
          Sancta Historia
        </Link>

        <div className="flex gap-4 text-sm font-medium text-[#4b3a2a]">
          <Link href="/" className="hover:text-[#8b5e24]">
            Timeline
          </Link>

          <Link href="/santos" className="hover:text-[#8b5e24]">
            Santos
          </Link>

          <Link href="/#mapa" className="hover:text-[#8b5e24]">
            Mapa
          </Link>
        </div>
      </nav>
    </header>
  );
}