"use client";

export default function AboutModal({ onClose }: { onClose: () => void }) {
  return (
    <div
      className="pointer-events-auto fixed inset-0 z-50 flex items-center justify-center bg-black/60 p-4"
      onClick={onClose}
    >
      <div
        className="panel-glass border rounded-xl max-w-lg w-full p-6"
        onClick={(e) => e.stopPropagation()}
      >
        <h2 className="font-display text-lg tracking-[0.1em] text-gold-200 mb-3">
          SOBRE O PROJETO
        </h2>
        <p className="text-parchment-dim leading-relaxed">
          Sancta Historia é uma plataforma interativa para explorar a história dos santos
          da Igreja Católica através de uma linha do tempo dinâmica, mapa mundial interativo
          e correlação com os acontecimentos históricos de cada época.
        </p>
        <ul className="mt-4 space-y-1 text-sm text-parchment-dim list-disc list-inside">
          <li>Linha do tempo de Jesus Cristo até os dias atuais</li>
          <li>Santos contextualizados historicamente</li>
          <li>Mapa interativo das jornadas dos santos</li>
          <li>Eventos mundiais correlacionados</li>
          <li>Papas e concílios</li>
        </ul>
        <button
          type="button"
          onClick={onClose}
          className="mt-6 rounded-full border border-gold-500/40 px-4 py-2 text-xs tracking-[0.15em] text-gold-300 hover:bg-gold-500/10 transition"
        >
          FECHAR
        </button>
      </div>
    </div>
  );
}
