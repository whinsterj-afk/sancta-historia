-- Santos sem ano de nascimento ou de morte sumiam do painel do período.
--
-- app/page.tsx filtrava com birth_year <= ano <= death_year. Em SQL, uma
-- comparação com null nunca é verdadeira, então 15 dos 93 santos jamais
-- apareciam: Nossa Senhora, São José, Santa Maria Madalena, Santa Ana,
-- Santo Estêvão, São Cosme, São Damião, São Bartolomeu, São Filipe,
-- São Judas Tadeu, São Mateus, São Matias, São Simão Zelote,
-- São Tiago Menor e Santa Felicidade.
--
-- A correção não inventa datas: birth_year e death_year continuam nulos
-- quando a história não os confirma, e a interface segue exibindo a vida
-- como incerta. A view apenas acrescenta um intervalo de exibição,
-- derivado nesta ordem:
--   1. o ano cadastrado, quando existe;
--   2. os anos da trajetória do santo, que são dados reais e já
--      publicados (12 dos 15 casos têm trajetória);
--   3. só em último caso, uma janela de 80 anos a partir do ano
--      conhecido do outro extremo, para que um santo com morte em 287 e
--      nascimento desconhecido não ocupe toda a linha do tempo.
--
-- O passo 3 é regra de exibição, não afirmação histórica: nada dele
-- chega ao usuário como data de nascimento ou de morte.

begin;

create or replace view public.saints_catalog
with (security_invoker = true)
as
select
  saints.id,
  saints.name,
  saints.birth_year,
  saints.death_year,
  saints.birth_place,
  saints.death_place,
  saints.short_description,
  saints.biography,
  saints.feast_day,
  saints.canonization_year,
  saints.patron_of,
  saints.image_url,
  saints.religious_order,
  saints.category,
  saints.famous_quote,
  saints.canonization_note,
  saints.historical_importance,
  saints.sources,
  saints.birth_year_note,
  saints.death_year_note,
  saints.slug,
  saints.is_published,
  coalesce(
    saints.birth_year,
    bounds.first_year,
    coalesce(saints.death_year, bounds.last_year) - 80
  ) as display_start_year,
  coalesce(
    saints.death_year,
    bounds.last_year,
    coalesce(saints.birth_year, bounds.first_year) + 80
  ) as display_end_year
from public.saints
left join lateral (
  select
    min(trajectory.start_year) as first_year,
    max(trajectory.end_year) as last_year
  from public.saint_trajectory_points as trajectory
  join public.places
    on places.id = trajectory.place_id
  where trajectory.saint_id = saints.id
    and trajectory.is_published
    and places.is_published
    and trajectory.point_kind in ('life', 'mission', 'martyrdom', 'tradition')
) as bounds on true
where saints.is_published;

grant select on public.saints_catalog to anon, authenticated;

comment on view public.saints_catalog is
  'Catálogo público de santos. display_start_year e display_end_year são '
  'o intervalo usado pela linha do tempo quando birth_year ou death_year '
  'são desconhecidos; não são datas históricas e não devem ser exibidos '
  'como tais.';

commit;
