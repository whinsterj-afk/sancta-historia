-- Remove a política legada que tornava redundante o filtro canônico de santos.

begin;

drop policy if exists "Enable read access for all users"
  on public.saints;

commit;

select
  policyname,
  roles,
  cmd,
  qual
from pg_policies
where schemaname = 'public'
  and tablename = 'saints'
order by policyname;
