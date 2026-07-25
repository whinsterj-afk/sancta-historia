# Sancta Historia — resumo de continuidade

Última atualização: 25 de julho de 2026.

## Estado atual

O layout do protótipo `sancta-historia-next-layout.zip` foi integrado ao projeto
Next.js existente sem substituir as funcionalidades conectadas ao Supabase e ao
MapLibre.

O projeto está salvo localmente, mas ainda não foi criado um commit. O diretório
de trabalho já continha mudanças antes desta integração; por isso, todas foram
preservadas.

## Concluído

- Layout principal com mapa em tela cheia, brasão central, busca, painéis
  laterais e linha do tempo.
- Responsividade para desktop, tablets e celulares.
- Zonas seguras para reduzir sobreposição entre brasão, painéis e controles.
- Painéis laterais com fundo em degradê até transparência total na direção do
  centro do mapa.
- Separadores dos painéis também desaparecem gradualmente.
- Painel “Santos da Época” alinhado à direita, próximo à região opaca.
- Legenda do mapa e barra dourada inferior removidas.
- Brasão em CSS substituído pela imagem `public/sancta-historia-crest.png`.
- Consulta ao Supabase atualizada conforme o ano selecionado.
- Marcadores do mapa recriados conforme os santos do período.
- Um único marcador é centralizado com `easeTo`.
- Vários marcadores são enquadrados com `fitBounds`.
- O enquadramento reserva espaço para painéis, cabeçalho e controles inferiores.
- Preferência de redução de movimento é respeitada.
- Estilo personalizado do MapTiler configurado em `components/SaintsMap.tsx`.
- Página individual de santo em `/saints/[id]` preservada.

## Arquivos principais

- `app/page.tsx`: composição da tela e carregamento dos dados.
- `app/page.module.css`: posicionamento geral e responsividade.
- `app/globals.css`: identidade visual, painéis, degradês e controles.
- `components/SaintsMap.tsx`: MapLibre, marcadores, zoom e estilo MapTiler.
- `components/Timeline.tsx`: seleção do ano.
- `components/FactsPanel.tsx`: fatos históricos.
- `components/SaintsPanel.tsx`: santos da época e favoritos.
- `components/TopBar.tsx`: cabeçalho, brasão e busca.

## Validação

Na última execução:

- ESLint do código da aplicação passou.
- TypeScript passou.
- `next build` passou com Next.js 16.2.9.
- Rotas verificadas: `/`, `/_not-found` e `/saints/[id]`.

## Pontos para revisar na próxima sessão

1. Abrir a aplicação em diferentes resoluções e fazer uma revisão visual fina
   do posicionamento dos painéis e da linha do tempo.
2. Confirmar visualmente se o alinhamento à direita do painel de santos está
   exatamente como desejado.
3. Testar o zoom do mapa com períodos contendo zero, um e vários santos.
4. Implementar a busca do cabeçalho, que atualmente é somente visual.
5. Definir as ações ainda não implementadas do menu superior.
6. Considerar mover a chave pública do MapTiler para `.env.local`, mantendo o
   URL do estilo no código sem a chave literal.
7. Revisar os logs de configuração do Supabase exibidos durante o build.

## Observação sobre Git

Há arquivos modificados e novos ainda sem commit. Antes de criar um commit,
revisar `git status` para separar mudanças anteriores do usuário das mudanças
do layout.
