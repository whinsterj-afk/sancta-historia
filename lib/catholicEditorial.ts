type IdentifiedRecord = {
  id: number;
};

const saintEditorial: Record<number, Record<string, string>> = {
  1: {
    short_description:
      "Filho eterno de Deus feito homem, Senhor e Salvador do mundo.",
    biography:
      "Jesus Cristo é o Filho eterno de Deus, consubstancial ao Pai, que se encarnou no seio da Virgem Maria e nasceu em Belém, na plenitude dos tempos. Verdadeiro Deus e verdadeiro homem, Ele é o centro da história da salvação.\n\nOs santos Evangelhos testemunham que Jesus viveu na Palestina do século I, anunciou o Reino de Deus, realizou sinais, chamou os discípulos, instituiu a Igreja sobre os Apóstolos e entregou livremente sua vida na cruz, em Jerusalém, para a redenção da humanidade. Ressuscitou ao terceiro dia, venceu o pecado e a morte e permanece vivo e presente em sua Igreja.\n\nA contagem dos anos a.C. e d.C. foi estabelecida séculos depois. Por essa razão, os estudos históricos podem situar o nascimento de Jesus alguns anos antes do ano 1 d.C.; essa questão de cronologia não altera a verdade de que Cristo é o Senhor da história e o centro da história da salvação.",
    historical_importance:
      "Jesus Cristo é o Filho eterno de Deus feito homem, o centro da história da salvação. Nascido da Virgem Maria em Belém, morreu na cruz e ressuscitou ao terceiro dia para a redenção da humanidade. O calendário cristão O toma como referência central, embora a contagem a.C. e d.C., calculada séculos depois, não permita determinar com exatidão civil o ano de seu nascimento.",
  },
  50: {
    short_description:
      "Mãe de Jesus Cristo e verdadeira Mãe de Deus, a Theotokos.",
    biography:
      "A Virgem Maria é a Mãe de Jesus Cristo, verdadeiro Deus e verdadeiro homem. Concebeu o Filho de Deus por obra do Espírito Santo, acompanhou sua vida e missão e permaneceu junto à cruz e à Igreja nascente. Por ser Mãe de Cristo, a Igreja a confessa verdadeiramente como Theotokos, Mãe de Deus, título solenemente proclamado no Concílio de Éfeso.\n\nAs fontes não preservaram com precisão o ano e o local de seu nascimento. A Igreja venera Maria de modo singular como a Imaculada Mãe de Deus, sempre Virgem, elevada ao Céu em corpo e alma, modelo perfeito de fé e primeira entre os discípulos de seu Filho.",
  },
  51: {
    biography:
      "São José é o esposo castíssimo da Virgem Maria, pai legal de Jesus e guarda fiel da Sagrada Família. Homem justo e obediente à vontade de Deus, acolheu Maria, protegeu o Menino Jesus e exerceu sua missão paterna com humildade e silêncio.\n\nOs Evangelhos não registram sua morte nem oferecem uma cronologia completa de sua vida. A Igreja o venera como patrono da Igreja universal, modelo dos trabalhadores, dos pais e de todos os que servem fielmente a Deus.",
  },
  52: {
    biography:
      "São João Batista é o Precursor de Cristo, o profeta enviado para preparar os caminhos do Senhor. Pregou a conversão no deserto, batizou Jesus no Jordão e O apresentou ao povo como o Cordeiro de Deus.\n\nPor testemunhar a verdade diante de Herodes Antipas, foi preso e martirizado. O local de sua morte é tradicionalmente associado à fortaleza de Maqueronte, embora as fontes não permitam estabelecer todos os detalhes geográficos com plena certeza.",
  },
  53: {
    short_description:
      "Apóstolo, irmão de São Pedro e primeiro discípulo chamado por Jesus.",
    biography:
      "Santo André, pescador da Galileia e irmão de São Pedro, foi um dos primeiros discípulos chamados por Jesus. O Evangelho segundo São João o apresenta conduzindo Pedro até Cristo.\n\nA antiga tradição da Igreja recorda sua missão em regiões do mundo grego e seu martírio em Patras, numa cruz em forma de X. A forma exata de seu martírio pertence ao testemunho tradicional recebido pelas comunidades cristãs.",
  },
  58: {
    short_description:
      "Apóstolo que confessou Jesus ressuscitado como Senhor e Deus.",
    biography:
      "São Tomé, chamado Dídimo, é o Apóstolo que, diante de Cristo ressuscitado, professou: “Meu Senhor e meu Deus”. A antiga tradição siro-malabar e a memória viva dos cristãos de São Tomé testemunham sua missão evangelizadora na Índia.\n\nSeu martírio é venerado em Mylapore desde a antiguidade. Embora não tenham sido preservados documentos contemporâneos que descrevam todo o percurso, essa tradição ocupa um lugar fundamental na história da Igreja na Índia.",
  },
  63: {
    biography:
      "Os Atos dos Apóstolos narram que São Matias foi escolhido para ocupar o lugar de Judas Iscariotes no colégio dos Doze. Sua eleição manifesta a continuidade da missão apostólica e o cuidado da Igreja nascente em conservar o testemunho dos Apóstolos.\n\nAs tradições antigas divergem sobre os lugares de sua missão e de seu martírio, detalhes que não foram preservados com segurança pelas fontes históricas.",
  },
  64: {
    short_description:
      "Evangelista, discípulo de São Pedro e fundador da Igreja de Alexandria.",
    biography:
      "São Marcos Evangelista, identificado pela Tradição da Igreja com João Marcos dos Atos dos Apóstolos, foi discípulo e intérprete da pregação de São Pedro e autor do segundo Evangelho. Fundou a Igreja de Alexandria, que o honra como seu primeiro bispo.\n\nA antiga tradição cristã testemunha seu martírio em Alexandria. Nem todos os detalhes cronológicos de sua vida foram preservados pelas fontes, mas sua missão apostólica e seu Evangelho permanecem como herança perene da Igreja.",
  },
};

const eventEditorial: Record<number, Record<string, string>> = {
  11: {
    description:
      "Paixão, morte redentora e Ressurreição gloriosa de Jesus Cristo.",
  },
};

const locationEditorial: Record<number, Record<string, string>> = {
  36: {
    description: "Lugar do nascimento de Jesus Cristo.",
  },
  37: {
    description: "Cidade onde Jesus viveu sua infância e sua vida oculta.",
  },
  38: {
    description:
      "Lugar da Paixão, morte redentora e Ressurreição gloriosa de Jesus Cristo.",
  },
  45: {
    description:
      "Refúgio da Sagrada Família durante a fuga para o Egito; o local exato não foi preservado pelas fontes.",
  },
};

function applyEditorial<T extends IdentifiedRecord>(
  record: T,
  revisions: Record<number, Record<string, string>>,
) {
  const revision = revisions[record.id];
  return revision ? ({ ...record, ...revision } as T) : record;
}

export function applySaintEditorial<T extends IdentifiedRecord>(saint: T) {
  return applyEditorial(saint, saintEditorial);
}

export function applyEventEditorial<T extends IdentifiedRecord>(event: T) {
  return applyEditorial(event, eventEditorial);
}

export function applyLocationEditorial<T extends IdentifiedRecord>(location: T) {
  return applyEditorial(location, locationEditorial);
}
