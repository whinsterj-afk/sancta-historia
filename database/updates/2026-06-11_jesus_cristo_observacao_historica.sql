begin;

alter table saints
add column if not exists birth_year_note text,
add column if not exists death_year_note text,
add column if not exists historical_importance text,
add column if not exists sources text,
add column if not exists canonization_note text;

update saints
set
  birth_year = -6,
  death_year = 33,
  birth_year_note = 'c. 6–4 a.C.',
  death_year_note = 'c. 30 ou 33 d.C.',
  short_description = 'Figura central do cristianismo, Filho de Deus feito homem e Salvador do mundo.',
  biography = 'Jesus Cristo é, para a fé católica, o Filho eterno de Deus que se encarnou no seio da Virgem Maria e nasceu em Belém, na plenitude dos tempos. Sua vida, morte e ressurreição constituem o centro da fé cristã e da história da salvação.

Segundo os Evangelhos, Jesus viveu na Palestina do século I, anunciou o Reino de Deus, realizou sinais, chamou discípulos, instituiu a Igreja sobre os Apóstolos e entregou sua vida na cruz em Jerusalém. A Igreja confessa que Ele ressuscitou ao terceiro dia, venceu o pecado e a morte, e permanece vivo e presente em sua Igreja.

Embora a era cristã tome Cristo como referência central da história, o sistema de contagem a.C./d.C. foi calculado séculos depois. Por isso, estudos históricos costumam situar seu nascimento alguns anos antes do ano 1 d.C., sem alterar a fé da Igreja de que Jesus Cristo é o centro da história da salvação.',
  feast_day = '25 de dezembro',
  canonization_year = null,
  canonization_note = 'Não se aplica; Jesus Cristo é o Filho de Deus, Senhor e Salvador, não um santo canonizado.',
  patron_of = 'Humanidade, Igreja e salvação do mundo',
  religious_order = null,
  category = 'Jesus Cristo, Salvador, Filho de Deus',
  famous_quote = 'Eu sou o caminho, a verdade e a vida.',
  historical_importance = 'Jesus Cristo é o centro da fé católica e da história da salvação. A Igreja confessa que Ele é o Filho eterno de Deus feito homem, nascido da Virgem Maria em Belém, morto e ressuscitado para a redenção da humanidade. Embora o calendário cristão use Cristo como referência histórica, sua data exata de nascimento é tratada historicamente como aproximada, pois o sistema a.C./d.C. foi calculado séculos depois.',
  sources = 'Catecismo da Igreja Católica; Evangelhos de Mateus, Marcos, Lucas e João; tradição litúrgica da Igreja; Vaticano.'
where name = 'Jesus Cristo';

commit;