-- Restringe a superfície pública da área de perfil sem alterar o fluxo do
-- frontend. As funções SECURITY DEFINER continuam executadas pelos gatilhos.

begin;

create index if not exists profiles_favorite_saint_id_idx
  on public.profiles (favorite_saint_id)
  where favorite_saint_id is not null;

create index if not exists profiles_favorite_parish_id_idx
  on public.profiles (favorite_parish_id)
  where favorite_parish_id is not null;

revoke execute on function public.handle_new_user()
  from public, anon, authenticated;
revoke execute on function public.sync_saint_devotee_count()
  from public, anon, authenticated;

drop policy if exists "Public read avatar images" on storage.objects;
drop policy if exists "Users read own avatar objects" on storage.objects;
create policy "Users read own avatar objects"
on storage.objects
for select
to authenticated
using (
  bucket_id = 'avatars'
  and (select auth.uid())::text = (storage.foldername(name))[1]
);

revoke all privileges on table public.profiles from anon;
revoke delete, truncate, references, trigger
  on table public.profiles from authenticated;
grant select, insert, update on table public.profiles to authenticated;

revoke insert, update, delete, truncate, references, trigger
  on table public.ecclesiastical_jurisdictions,
           public.ecclesiastical_sites
  from anon, authenticated;
grant select
  on table public.ecclesiastical_jurisdictions,
           public.ecclesiastical_sites
  to anon, authenticated;

commit;
