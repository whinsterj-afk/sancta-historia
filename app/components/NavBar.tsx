import Link from "next/link";

const navItems = [
  { href: "/", label: "Timeline" },
  { href: "/santos", label: "Santos" },
  { href: "/papas", label: "Papas" },
  { href: "/eventos", label: "Eventos" },
  { href: "/locais", label: "Locais" },
  { href: "/sobre", label: "Sobre" },
];

export default function NavBar() {
  return (
    <header className="fixed inset-x-0 top-0 z-30 px-4 pt-4 text-[#fffaf0] sm:px-6">
      <nav className="mx-auto flex max-w-5xl flex-col items-center gap-3">
        <Link href="/" className="group flex items-center gap-3">
          <span className="grid h-10 w-10 place-items-center rounded-full border border-[#e0c48e]/70 bg-[#211914]/78 text-sm font-semibold tracking-wide text-[#e0c48e] shadow-[0_12px_34px_rgba(0,0,0,0.28)] backdrop-blur-xl">
            SH
          </span>
          <span className="text-2xl font-semibold tracking-wide text-white drop-shadow-[0_2px_12px_rgba(0,0,0,0.55)] transition group-hover:text-[#e0c48e]">
            Sancta Historia
          </span>
        </Link>

        <div className="flex max-w-full gap-1 overflow-x-auto rounded-full border border-white/14 bg-[#211914]/72 p-1 text-sm font-medium text-[#f4e7d1] shadow-[0_16px_44px_rgba(0,0,0,0.24)] backdrop-blur-xl">
          {navItems.map((item) => (
            <Link
              key={item.href}
              href={item.href}
              className="shrink-0 rounded-full px-3 py-2 transition hover:bg-[#e0c48e]/18 hover:text-white"
            >
              {item.label}
            </Link>
          ))}
        </div>
      </nav>
    </header>
  );
}
