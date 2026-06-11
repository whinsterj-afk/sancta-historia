export default function SobrePage() {
  return (
    <main className="min-h-screen max-w-5xl mx-auto p-8">
      <section className="mb-12">
        <h1 className="text-5xl font-bold mb-4 text-[#2b1b10]">
          Sobre o Sancta Historia
        </h1>

        <p className="text-lg text-[#4b3a2a] leading-relaxed">
          O Sancta Historia é uma plataforma interativa dedicada à história
          dos santos da Igreja Católica, conectando pessoas, lugares, papas,
          acontecimentos históricos e períodos da civilização cristã em uma
          única experiência visual.
        </p>
      </section>

      <section className="bg-[#fffaf0] border border-[#c9b895] rounded-2xl p-6 shadow-sm mb-8">
        <h2 className="text-3xl font-bold mb-4 text-[#2b1b10]">
          A missão
        </h2>

        <p className="text-[#4b3a2a] leading-relaxed">
          Nossa missão é tornar a história da santidade cristã mais acessível,
          visual e compreensível. Através de uma linha do tempo interativa, o
          usuário pode navegar por dois mil anos de história e compreender em
          que contexto cada santo viveu, onde atuou e quais acontecimentos
          marcavam o mundo naquele período.
        </p>
      </section>

      <section className="grid md:grid-cols-2 gap-6 mb-8">
        <div className="bg-[#fffaf0] border border-[#c9b895] rounded-2xl p-6 shadow-sm">
          <h2 className="text-2xl font-bold mb-3 text-[#2b1b10]">
            Linha do tempo
          </h2>

          <p className="text-[#4b3a2a] leading-relaxed">
            A timeline permite escolher um ano específico e visualizar quais
            santos estavam vivos naquele período, quem era o Papa e quais
            eventos históricos estavam ocorrendo próximos daquele momento.
          </p>
        </div>

        <div className="bg-[#fffaf0] border border-[#c9b895] rounded-2xl p-6 shadow-sm">
          <h2 className="text-2xl font-bold mb-3 text-[#2b1b10]">
            Mapa histórico
          </h2>

          <p className="text-[#4b3a2a] leading-relaxed">
            O mapa mostra os lugares associados à vida dos santos. Ele permite
            visualizar geograficamente a expansão da fé cristã e a atuação dos
            santos ao longo dos séculos.
          </p>
        </div>

        <div className="bg-[#fffaf0] border border-[#c9b895] rounded-2xl p-6 shadow-sm">
          <h2 className="text-2xl font-bold mb-3 text-[#2b1b10]">
            Contexto histórico
          </h2>

          <p className="text-[#4b3a2a] leading-relaxed">
            Cada santo é apresentado dentro do seu tempo. O objetivo não é
            apenas contar uma biografia, mas mostrar o que acontecia na Igreja
            e no mundo quando aquele santo viveu.
          </p>
        </div>

        <div className="bg-[#fffaf0] border border-[#c9b895] rounded-2xl p-6 shadow-sm">
          <h2 className="text-2xl font-bold mb-3 text-[#2b1b10]">
            Uma enciclopédia visual
          </h2>

          <p className="text-[#4b3a2a] leading-relaxed">
            O projeto busca se tornar uma enciclopédia visual da santidade
            cristã, reunindo santos, papas, concílios, eventos históricos,
            ordens religiosas, lugares e trajetórias missionárias.
          </p>
        </div>
      </section>

      <section className="bg-[#2b1b10] text-[#fffaf0] rounded-2xl p-8">
        <h2 className="text-3xl font-bold mb-4">
          Visão de futuro
        </h2>

        <p className="leading-relaxed">
          O Sancta Historia pretende evoluir para uma plataforma completa de
          pesquisa, catequese e formação histórica, com biografias aprofundadas,
          mapas interativos, rotas missionárias, fontes documentais, relações
          entre santos e recursos de inteligência artificial baseados em fontes
          confiáveis da tradição católica.
        </p>
      </section>
    </main>
  );
}