# Pesquisa e expansão de dados

Este documento define o fluxo operacional para ampliar o conteúdo do
Sancta Historia sem publicar rascunhos, perder a procedência ou misturar
fontes históricas com dados cartográficos.

## Princípios

1. Nenhum texto ou ponto novo é inventado. Cada afirmação verificável
   deve ter uma fonte identificável.
2. Fontes oficiais da Santa Sé, dioceses e ordens religiosas têm
   prioridade. Fontes secundárias confiáveis complementam lacunas e
   divergências devem permanecer registradas para revisão.
3. Textos são redigidos em português do Brasil e seguem a voz editorial
   católica do `AGENTS.md`.
4. Rascunhos ficam no schema privado `research`. O frontend continua
   lendo somente as tabelas e views públicas.
5. Não copiar textos extensos nem imagens sem licença. Para mídia,
   registrar origem, autoria, licença e atribuição antes de publicar.

## Funil de trabalho

```
fonte identificada
  -> coleta bruta
  -> normalização
  -> verificação histórica/canônica
  -> revisão editorial
  -> promoção para public.*
  -> auditoria no mapa e na linha do tempo
```

Os estados de `research.saint_reviews` são:

- `queued`: aguardando pesquisa;
- `in_progress`: pesquisa ativa;
- `researched`: campos e fontes coletados;
- `reviewed`: conteúdo e fontes revisados;
- `published`: alteração promovida para `public.saints`;
- `blocked`: divergência ou fonte insuficiente registrada em
  `research_notes`.

Um santo só pode passar a `published` depois de:

- ter nome, datas e lugares conferidos;
- ter biografia e descrição revisadas na voz editorial do projeto;
- ter festa litúrgica e categoria verificadas;
- distinguir canonização formal de culto imemorial ou anterior ao
  processo moderno;
- ter ao menos uma fonte adequada vinculada em
  `public.saint_source_citations`;
- ter qualquer imagem verificada quanto a licença e atribuição.

## Santos existentes

Os 93 santos publicados foram distribuídos automaticamente por
quantidade de lacunas e cronologia:

| Lote | Registros | Estado inicial |
| --- | ---: | --- |
| `saints-existing-audit-01` | 25 | `ready` |
| `saints-existing-audit-02` | 25 | `planned` |
| `saints-existing-audit-03` | 25 | `planned` |
| `saints-existing-audit-04` | 18 | `planned` |

O primeiro lote concentra os registros com seis lacunas: biografia,
festa, contexto de canonização/culto, imagem, categoria e fontes.
Concluir esse lote antes de iniciar a coleta de novos santos.

Novos nomes entram primeiro em `research.saint_candidates`. Duplicatas
e variantes de nome devem ser resolvidas antes de criar uma linha em
`public.saints`.

## Circunscrições e locais eclesiásticos

A primeira fase mundial coleta circunscrições, não todas as paróquias
nem todos os edifícios. As metas de conferência vêm de *Catholic Church
Statistics 2025*, com dados de 31 de dezembro de 2023:

| Lote | Meta de circunscrições |
| --- | ---: |
| África | 554 |
| Américas | 1.102 |
| Ásia | 545 |
| Europa | 759 |
| Oceania | 81 |
| **Total** | **3.041** |

Essas metas conferem cobertura agregada; elas não substituem o cadastro
canônico de cada entidade. O Annuario Pontificio Digital é a referência
atualizada prevista, mas exige assinatura. Não comprar acesso nem
automatizar extração sem aprovação do usuário e verificação dos termos
de uso.

Cada registro bruto entra em
`research.ecclesiastical_import_rows`. A promoção ocorre somente após:

- tipo canônico e rito/tradição conferidos;
- país e relação hierárquica validados;
- fonte e identificador de origem preservados;
- endereço e coordenadas conferidos;
- duplicidade descartada;
- nível de zoom definido conforme a hierarquia existente no mapa.

Geocodificação precisa permitir armazenamento permanente e uso em
produção. O Nominatim público não deve ser usado para importação em
massa; usar instância própria ou provedor com licença compatível.

## Fontes iniciais cadastradas

- Dicastério para as Causas dos Santos;
- Celebrações Litúrgicas Pontifícias — Santos;
- Dicastério para o Culto Divino e a Disciplina dos Sacramentos;
- *Catholic Church Statistics 2025*;
- Annuario Pontificio Digital.

`public.research_sources` guarda metadados da fonte. A citação de uma
página ou documento específico deve usar a URL específica, não apenas
a página institucional genérica.

## Contrato técnico

A migração
`supabase/migrations/20260726221526_add_content_research_workflow.sql`
cria:

- `research.batches`;
- `research.batch_sources`;
- `research.saint_reviews`;
- `research.saint_candidates`;
- `research.ecclesiastical_import_rows`.

O schema `research` não é exposto ao Data API e não concede `USAGE` a
`anon`, `authenticated` ou `service_role`. Não acessar essas tabelas
diretamente pelo frontend. Uma futura ferramenta administrativa deve
usar backend próprio e concessões mínimas em migração separada.
