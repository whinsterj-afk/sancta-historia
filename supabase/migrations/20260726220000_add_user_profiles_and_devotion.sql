-- Sancta Historia
-- Cria a área de usuário: perfil, santo de devoção e contador público de devotos.
-- profiles fica privado (só o próprio usuário lê/escreve); o contador é uma
-- tabela pública separada, mantida por trigger, para não expor linhas de
-- profiles via agregação (RLS + security_invoker não daria a soma real).

begin;

create table if not exists public.profiles (
  id uuid primary key
    references auth.users(id)
    on delete cascade,
  display_name text,
  avatar_url text,
  city text,
  country text,
  favorite_saint_id bigint
    references public.saints(id)
    on delete set null,
  created_at timestamp with time zone not null default now(),
  updated_at timestamp with time zone not null default now()
);

drop trigger if exists profiles_set_updated_at on public.profiles;
create trigger profiles_set_updated_at
before update on public.profiles
for each row
execute function public.set_updated_at();

alter table public.profiles enable row level security;

drop policy if exists "Users read own profile" on public.profiles;
create policy "Users read own profile"
on public.profiles
for select
to authenticated
using ((select auth.uid()) = id);

drop policy if exists "Users insert own profile" on public.profiles;
create policy "Users insert own profile"
on public.profiles
for insert
to authenticated
with check ((select auth.uid()) = id);

drop policy if exists "Users update own profile" on public.profiles;
create policy "Users update own profile"
on public.profiles
for update
to authenticated
using ((select auth.uid()) = id)
with check ((select auth.uid()) = id);

grant select, insert, update on public.profiles to authenticated;

-- Cria a linha de perfil automaticamente no primeiro login, pré-preenchendo
-- nome/foto vindos do provedor OAuth (apenas como valor inicial editável;
-- nunca usado para autorização). security definer é necessário aqui porque
-- o gatilho roda a partir de um insert em auth.users, fora do papel do
-- próprio usuário.
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
as $function$
begin
  insert into public.profiles (id, display_name, avatar_url)
  values (
    new.id,
    new.raw_user_meta_data ->> 'full_name',
    new.raw_user_meta_data ->> 'avatar_url'
  )
  on conflict (id) do nothing;
  return new;
end;
$function$;

alter function public.handle_new_user()
  set search_path = pg_catalog;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
after insert on auth.users
for each row
execute function public.handle_new_user();

create table if not exists public.saint_devotee_counts (
  saint_id bigint primary key
    references public.saints(id)
    on delete cascade,
  devotee_count integer not null default 0
    constraint saint_devotee_counts_nonnegative check (devotee_count >= 0)
);

alter table public.saint_devotee_counts enable row level security;

drop policy if exists "Public read devotee counts" on public.saint_devotee_counts;
create policy "Public read devotee counts"
on public.saint_devotee_counts
for select
to anon, authenticated
using (true);

grant select on public.saint_devotee_counts to anon, authenticated;

-- Mantém saint_devotee_counts em sincronia com profiles.favorite_saint_id.
-- security definer porque o usuário autenticado não tem (e não deve ter)
-- permissão de escrita direta na tabela de contagem pública.
create or replace function public.sync_saint_devotee_count()
returns trigger
language plpgsql
security definer
as $function$
begin
  if tg_op = 'INSERT' then
    if new.favorite_saint_id is not null then
      insert into public.saint_devotee_counts (saint_id, devotee_count)
      values (new.favorite_saint_id, 1)
      on conflict (saint_id) do update
        set devotee_count = public.saint_devotee_counts.devotee_count + 1;
    end if;
    return new;
  end if;

  if tg_op = 'UPDATE' then
    if new.favorite_saint_id is distinct from old.favorite_saint_id then
      if old.favorite_saint_id is not null then
        update public.saint_devotee_counts
        set devotee_count = greatest(devotee_count - 1, 0)
        where saint_id = old.favorite_saint_id;
      end if;

      if new.favorite_saint_id is not null then
        insert into public.saint_devotee_counts (saint_id, devotee_count)
        values (new.favorite_saint_id, 1)
        on conflict (saint_id) do update
          set devotee_count = public.saint_devotee_counts.devotee_count + 1;
      end if;
    end if;
    return new;
  end if;

  if tg_op = 'DELETE' then
    if old.favorite_saint_id is not null then
      update public.saint_devotee_counts
      set devotee_count = greatest(devotee_count - 1, 0)
      where saint_id = old.favorite_saint_id;
    end if;
    return old;
  end if;

  return null;
end;
$function$;

alter function public.sync_saint_devotee_count()
  set search_path = pg_catalog;

drop trigger if exists profiles_sync_devotee_count on public.profiles;
create trigger profiles_sync_devotee_count
after insert or update of favorite_saint_id or delete on public.profiles
for each row
execute function public.sync_saint_devotee_count();

-- Bucket público para fotos de perfil; caminho de cada arquivo começa com o
-- uid do usuário (ex.: avatars/<uid>/foto.jpg), o que as políticas abaixo
-- usam para restringir escrita ao dono.
insert into storage.buckets (id, name, public)
values ('avatars', 'avatars', true)
on conflict (id) do nothing;

drop policy if exists "Public read avatar images" on storage.objects;
create policy "Public read avatar images"
on storage.objects
for select
to anon, authenticated
using (bucket_id = 'avatars');

drop policy if exists "Users insert own avatar" on storage.objects;
create policy "Users insert own avatar"
on storage.objects
for insert
to authenticated
with check (
  bucket_id = 'avatars'
  and (select auth.uid())::text = (storage.foldername(name))[1]
);

drop policy if exists "Users update own avatar" on storage.objects;
create policy "Users update own avatar"
on storage.objects
for update
to authenticated
using (
  bucket_id = 'avatars'
  and (select auth.uid())::text = (storage.foldername(name))[1]
)
with check (
  bucket_id = 'avatars'
  and (select auth.uid())::text = (storage.foldername(name))[1]
);

comment on table public.profiles is
  'Perfil do usuário autenticado: nome, foto, localização e santo de devoção. Privado, só o próprio usuário lê/escreve.';
comment on table public.saint_devotee_counts is
  'Contagem pública de devotos por santo, mantida por trigger a partir de profiles.favorite_saint_id.';

commit;

select
  (select count(*) from public.profiles) as profiles_existentes,
  (select count(*) from public.saint_devotee_counts) as santos_com_devotos;
