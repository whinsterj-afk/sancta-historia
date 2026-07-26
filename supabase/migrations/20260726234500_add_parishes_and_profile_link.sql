-- Sancta Historia
-- Liga o perfil do usuário à paróquia a que pertence. Reaproveita
-- ecclesiastical_jurisdictions (canonical_type = 'parish'/'quasi_parish')
-- em vez de criar um catálogo de paróquias separado, para não ter duas
-- fontes de verdade para o mesmo conceito.

begin;

alter table public.profiles
  add column if not exists favorite_parish_id bigint
    references public.ecclesiastical_jurisdictions(id)
    on delete set null;

comment on column public.profiles.favorite_parish_id is
  'Paróquia à qual o usuário pertence: referencia ecclesiastical_jurisdictions(id) onde canonical_type in (''parish'', ''quasi_parish''). Sem constraint de banco garantindo o tipo — a busca no ProfileModal já filtra por esses tipos. Sem cadastro de paróquia pelo usuário: só lista as já publicadas em ecclesiastical_jurisdictions.';

commit;
