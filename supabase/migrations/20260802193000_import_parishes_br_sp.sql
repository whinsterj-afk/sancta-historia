-- Sancta Historia
-- Migração de Paróquias gerada automaticamente a partir de supabase/data/parishes/BR/SP.json
-- Operação idempotente via ON CONFLICT (slug) DO UPDATE

begin;

-- Jurisdiction: Catedral Metropolitana da Sé (Nossa Senhora da Assunção e São Paulo)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-catedral-metropolitana-da-se-nossa-senhora-da-assuncao-e-sao-paulo-0',
  'Catedral Metropolitana da Sé (Nossa Senhora da Assunção e São Paulo)',
  'parish',
  'latin',
  'BR',
  'active',
  1591,
  'Paróquia Catedral Metropolitana da Sé (Nossa Senhora da Assunção e São Paulo) localizada em São Paulo, estado de São Paulo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Catedral Metropolitana da Sé (Nossa Senhora da Assunção e São Paulo)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-catedral-metropolitana-da-se-nossa-senhora-da-assuncao-e-sao-paulo-0'),
  'site-catedral-metropolitana-da-se-nossa-senhora-da-assuncao-e-sao-paulo-0',
  'Catedral Metropolitana da Sé (Nossa Senhora da Assunção e São Paulo)',
  'cathedral',
  'Praça da Sé, s/n - Sé',
  'São Paulo',
  'São Paulo',
  'BR',
  st_setsrid(st_makepoint(-46.6333, -23.5505), 4326)::geography,
  10,
  3,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Santuário de São José de Anchieta - Pátio do Colégio
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-santuario-de-sao-jose-de-anchieta-patio-do-colegio-1',
  'Santuário de São José de Anchieta - Pátio do Colégio',
  'parish',
  'latin',
  'BR',
  'active',
  1554,
  'Paróquia Santuário de São José de Anchieta - Pátio do Colégio localizada em São Paulo, estado de São Paulo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Santuário de São José de Anchieta - Pátio do Colégio
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-santuario-de-sao-jose-de-anchieta-patio-do-colegio-1'),
  'site-santuario-de-sao-jose-de-anchieta-patio-do-colegio-1',
  'Santuário de São José de Anchieta - Pátio do Colégio',
  'shrine',
  'Praça Pátio do Colégio, 2 - Centro',
  'São Paulo',
  'São Paulo',
  'BR',
  st_setsrid(st_makepoint(-46.6328, -23.5481), 4326)::geography,
  10,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Nossa Senhora do Brasil
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-nossa-senhora-do-brasil-2',
  'Paróquia Nossa Senhora do Brasil',
  'parish',
  'latin',
  'BR',
  'active',
  1940,
  'Paróquia Paróquia Nossa Senhora do Brasil localizada em São Paulo, estado de São Paulo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Paróquia Nossa Senhora do Brasil
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-nossa-senhora-do-brasil-2'),
  'site-paroquia-nossa-senhora-do-brasil-2',
  'Paróquia Nossa Senhora do Brasil',
  'parish_church',
  'Praça N. Sra. do Brasil, s/n - Jardim América',
  'São Paulo',
  'São Paulo',
  'BR',
  st_setsrid(st_makepoint(-46.6712, -23.5678), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Basílica de Nossa Senhora da Assunção (Mosteiro de São Bento)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-basilica-de-nossa-senhora-da-assuncao-mosteiro-de-sao-bento-3',
  'Basílica de Nossa Senhora da Assunção (Mosteiro de São Bento)',
  'parish',
  'latin',
  'BR',
  'active',
  1598,
  'Paróquia Basílica de Nossa Senhora da Assunção (Mosteiro de São Bento) localizada em São Paulo, estado de São Paulo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Basílica de Nossa Senhora da Assunção (Mosteiro de São Bento)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-basilica-de-nossa-senhora-da-assuncao-mosteiro-de-sao-bento-3'),
  'site-basilica-de-nossa-senhora-da-assuncao-mosteiro-de-sao-bento-3',
  'Basílica de Nossa Senhora da Assunção (Mosteiro de São Bento)',
  'shrine',
  'Largo de São Bento, s/n - Centro',
  'São Paulo',
  'São Paulo',
  'BR',
  st_setsrid(st_makepoint(-46.6342, -23.5442), 4326)::geography,
  10,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Basílica de Nossa Senhora da Consolação
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-basilica-de-nossa-senhora-da-consolacao-4',
  'Basílica de Nossa Senhora da Consolação',
  'parish',
  'latin',
  'BR',
  'active',
  1799,
  'Paróquia Basílica de Nossa Senhora da Consolação localizada em São Paulo, estado de São Paulo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Basílica de Nossa Senhora da Consolação
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-basilica-de-nossa-senhora-da-consolacao-4'),
  'site-basilica-de-nossa-senhora-da-consolacao-4',
  'Basílica de Nossa Senhora da Consolação',
  'shrine',
  'R. da Consolação, 585 - Consolação',
  'São Paulo',
  'São Paulo',
  'BR',
  st_setsrid(st_makepoint(-46.6472, -23.5492), 4326)::geography,
  10,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Basílica Nossa Senhora da Conceição e Santa Ifigênia
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-basilica-nossa-senhora-da-conceicao-e-santa-ifigenia-5',
  'Basílica Nossa Senhora da Conceição e Santa Ifigênia',
  'parish',
  'latin',
  'BR',
  'active',
  1720,
  'Paróquia Basílica Nossa Senhora da Conceição e Santa Ifigênia localizada em São Paulo, estado de São Paulo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Basílica Nossa Senhora da Conceição e Santa Ifigênia
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-basilica-nossa-senhora-da-conceicao-e-santa-ifigenia-5'),
  'site-basilica-nossa-senhora-da-conceicao-e-santa-ifigenia-5',
  'Basílica Nossa Senhora da Conceição e Santa Ifigênia',
  'shrine',
  'R. Santa Ifigênia, 30 - Centro',
  'São Paulo',
  'São Paulo',
  'BR',
  st_setsrid(st_makepoint(-46.6368, -23.5412), 4326)::geography,
  10,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Catedral de Santo Amaro
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-catedral-de-santo-amaro-6',
  'Catedral de Santo Amaro',
  'parish',
  'latin',
  'BR',
  'active',
  1686,
  'Paróquia Catedral de Santo Amaro localizada em São Paulo, estado de São Paulo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Catedral de Santo Amaro
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-catedral-de-santo-amaro-6'),
  'site-catedral-de-santo-amaro-6',
  'Catedral de Santo Amaro',
  'cathedral',
  'Praça Dom Francisco de Souza - Santo Amaro',
  'São Paulo',
  'São Paulo',
  'BR',
  st_setsrid(st_makepoint(-46.7092, -23.6521), 4326)::geography,
  10,
  3,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Catedral de Santana
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-catedral-de-santana-7',
  'Catedral de Santana',
  'parish',
  'latin',
  'BR',
  'active',
  1895,
  'Paróquia Catedral de Santana localizada em São Paulo, estado de São Paulo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Catedral de Santana
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-catedral-de-santana-7'),
  'site-catedral-de-santana-7',
  'Catedral de Santana',
  'cathedral',
  'R. Voluntários da Pátria, 2060 - Santana',
  'São Paulo',
  'São Paulo',
  'BR',
  st_setsrid(st_makepoint(-46.6268, -23.5042), 4326)::geography,
  10,
  3,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Nossa Senhora do Ó
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-nossa-senhora-do-o-8',
  'Paróquia Nossa Senhora do Ó',
  'parish',
  'latin',
  'BR',
  'active',
  1610,
  'Paróquia Paróquia Nossa Senhora do Ó localizada em São Paulo, estado de São Paulo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Paróquia Nossa Senhora do Ó
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-nossa-senhora-do-o-8'),
  'site-paroquia-nossa-senhora-do-o-8',
  'Paróquia Nossa Senhora do Ó',
  'parish_church',
  'Largo da Matriz N. Sra. do Ó - Freguesia do Ó',
  'São Paulo',
  'São Paulo',
  'BR',
  st_setsrid(st_makepoint(-46.6992, -23.4795), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Nossa Senhora da Lapa
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-nossa-senhora-da-lapa-9',
  'Paróquia Nossa Senhora da Lapa',
  'parish',
  'latin',
  'BR',
  'active',
  1911,
  'Paróquia Paróquia Nossa Senhora da Lapa localizada em São Paulo, estado de São Paulo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Paróquia Nossa Senhora da Lapa
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-nossa-senhora-da-lapa-9'),
  'site-paroquia-nossa-senhora-da-lapa-9',
  'Paróquia Nossa Senhora da Lapa',
  'parish_church',
  'R. Afonso Sardinha, 160 - Lapa',
  'São Paulo',
  'São Paulo',
  'BR',
  st_setsrid(st_makepoint(-46.7012, -23.5212), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia São João Batista (Brás)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-sao-joao-batista-bras-10',
  'Paróquia São João Batista (Brás)',
  'parish',
  'latin',
  'BR',
  'active',
  1904,
  'Paróquia Paróquia São João Batista (Brás) localizada em São Paulo, estado de São Paulo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Paróquia São João Batista (Brás)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-sao-joao-batista-bras-10'),
  'site-paroquia-sao-joao-batista-bras-10',
  'Paróquia São João Batista (Brás)',
  'parish_church',
  'R. Piratininga, 613 - Brás',
  'São Paulo',
  'São Paulo',
  'BR',
  st_setsrid(st_makepoint(-46.6152, -23.5412), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia São Bento do Mooca
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-sao-bento-do-mooca-11',
  'Paróquia São Bento do Mooca',
  'parish',
  'latin',
  'BR',
  'active',
  1912,
  'Paróquia Paróquia São Bento do Mooca localizada em São Paulo, estado de São Paulo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Paróquia São Bento do Mooca
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-sao-bento-do-mooca-11'),
  'site-paroquia-sao-bento-do-mooca-11',
  'Paróquia São Bento do Mooca',
  'parish_church',
  'R. Taquari, 1100 - Mooca',
  'São Paulo',
  'São Paulo',
  'BR',
  st_setsrid(st_makepoint(-46.5982, -23.5582), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Nossa Senhora da Conceição (Ipiranga)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-nossa-senhora-da-conceicao-ipiranga-12',
  'Paróquia Nossa Senhora da Conceição (Ipiranga)',
  'parish',
  'latin',
  'BR',
  'active',
  1925,
  'Paróquia Paróquia Nossa Senhora da Conceição (Ipiranga) localizada em São Paulo, estado de São Paulo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Paróquia Nossa Senhora da Conceição (Ipiranga)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-nossa-senhora-da-conceicao-ipiranga-12'),
  'site-paroquia-nossa-senhora-da-conceicao-ipiranga-12',
  'Paróquia Nossa Senhora da Conceição (Ipiranga)',
  'parish_church',
  'R. Moreira e Costa, 140 - Ipiranga',
  'São Paulo',
  'São Paulo',
  'BR',
  st_setsrid(st_makepoint(-46.6082, -23.5852), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Nossa Senhora Aparecida (Moema)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-nossa-senhora-aparecida-moema-13',
  'Paróquia Nossa Senhora Aparecida (Moema)',
  'parish',
  'latin',
  'BR',
  'active',
  1933,
  'Paróquia Paróquia Nossa Senhora Aparecida (Moema) localizada em São Paulo, estado de São Paulo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Paróquia Nossa Senhora Aparecida (Moema)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-nossa-senhora-aparecida-moema-13'),
  'site-paroquia-nossa-senhora-aparecida-moema-13',
  'Paróquia Nossa Senhora Aparecida (Moema)',
  'parish_church',
  'Praça N. Sra. Aparecida - Moema',
  'São Paulo',
  'São Paulo',
  'BR',
  st_setsrid(st_makepoint(-46.6612, -23.6052), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia São Paulo Apóstolo (Pinheiros)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-sao-paulo-apostolo-pinheiros-14',
  'Paróquia São Paulo Apóstolo (Pinheiros)',
  'parish',
  'latin',
  'BR',
  'active',
  1945,
  'Paróquia Paróquia São Paulo Apóstolo (Pinheiros) localizada em São Paulo, estado de São Paulo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Paróquia São Paulo Apóstolo (Pinheiros)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-sao-paulo-apostolo-pinheiros-14'),
  'site-paroquia-sao-paulo-apostolo-pinheiros-14',
  'Paróquia São Paulo Apóstolo (Pinheiros)',
  'parish_church',
  'R. Cardeal Arcoverde, 1250 - Pinheiros',
  'São Paulo',
  'São Paulo',
  'BR',
  st_setsrid(st_makepoint(-46.6912, -23.5652), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Cristo Rei (Tatuapé)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-cristo-rei-tatuape-15',
  'Paróquia Cristo Rei (Tatuapé)',
  'parish',
  'latin',
  'BR',
  'active',
  1935,
  'Paróquia Paróquia Cristo Rei (Tatuapé) localizada em São Paulo, estado de São Paulo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Paróquia Cristo Rei (Tatuapé)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-cristo-rei-tatuape-15'),
  'site-paroquia-cristo-rei-tatuape-15',
  'Paróquia Cristo Rei (Tatuapé)',
  'parish_church',
  'R. Maria Eugênia, 104 - Tatuapé',
  'São Paulo',
  'São Paulo',
  'BR',
  st_setsrid(st_makepoint(-46.5712, -23.5412), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Catedral de São Miguel Arcanjo (São Miguel Paulista)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-catedral-de-sao-miguel-arcanjo-sao-miguel-paulista-16',
  'Catedral de São Miguel Arcanjo (São Miguel Paulista)',
  'parish',
  'latin',
  'BR',
  'active',
  1622,
  'Paróquia Catedral de São Miguel Arcanjo (São Miguel Paulista) localizada em São Paulo, estado de São Paulo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Catedral de São Miguel Arcanjo (São Miguel Paulista)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-catedral-de-sao-miguel-arcanjo-sao-miguel-paulista-16'),
  'site-catedral-de-sao-miguel-arcanjo-sao-miguel-paulista-16',
  'Catedral de São Miguel Arcanjo (São Miguel Paulista)',
  'cathedral',
  'Praça Pe. Aleixo Monteiro Mafra - São Miguel',
  'São Paulo',
  'São Paulo',
  'BR',
  st_setsrid(st_makepoint(-46.4412, -23.4912), 4326)::geography,
  10,
  3,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Catedral de Campo Limpo
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-catedral-de-campo-limpo-17',
  'Catedral de Campo Limpo',
  'parish',
  'latin',
  'BR',
  'active',
  1989,
  'Paróquia Catedral de Campo Limpo localizada em São Paulo, estado de São Paulo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Catedral de Campo Limpo
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-catedral-de-campo-limpo-17'),
  'site-catedral-de-campo-limpo-17',
  'Catedral de Campo Limpo',
  'cathedral',
  'Estrada do Campo Limpo - Campo Limpo',
  'São Paulo',
  'São Paulo',
  'BR',
  st_setsrid(st_makepoint(-46.7582, -23.6452), 4326)::geography,
  10,
  3,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Santuário de São Judas Tadeu (Jabaquara)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-santuario-de-sao-judas-tadeu-jabaquara-18',
  'Paróquia Santuário de São Judas Tadeu (Jabaquara)',
  'parish',
  'latin',
  'BR',
  'active',
  1940,
  'Paróquia Paróquia Santuário de São Judas Tadeu (Jabaquara) localizada em São Paulo, estado de São Paulo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Paróquia Santuário de São Judas Tadeu (Jabaquara)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-santuario-de-sao-judas-tadeu-jabaquara-18'),
  'site-paroquia-santuario-de-sao-judas-tadeu-jabaquara-18',
  'Paróquia Santuário de São Judas Tadeu (Jabaquara)',
  'shrine',
  'Av. Jabaquara, 2682 - Jabaquara',
  'São Paulo',
  'São Paulo',
  'BR',
  st_setsrid(st_makepoint(-46.6392, -23.6182), 4326)::geography,
  10,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Catedral de Nossa Senhora do Carmo (Santo André)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-catedral-de-nossa-senhora-do-carmo-santo-andre-19',
  'Catedral de Nossa Senhora do Carmo (Santo André)',
  'parish',
  'latin',
  'BR',
  'active',
  1913,
  'Paróquia Catedral de Nossa Senhora do Carmo (Santo André) localizada em Santo André, estado de São Paulo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Catedral de Nossa Senhora do Carmo (Santo André)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-catedral-de-nossa-senhora-do-carmo-santo-andre-19'),
  'site-catedral-de-nossa-senhora-do-carmo-santo-andre-19',
  'Catedral de Nossa Senhora do Carmo (Santo André)',
  'cathedral',
  'Praça do Carmo - Centro',
  'Santo André',
  'São Paulo',
  'BR',
  st_setsrid(st_makepoint(-46.5312, -23.6582), 4326)::geography,
  10,
  3,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Catedral de Nossa Senhora da Boa Viagem (São Bernardo do Campo)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-catedral-de-nossa-senhora-da-boa-viagem-sao-bernardo-do-campo-20',
  'Catedral de Nossa Senhora da Boa Viagem (São Bernardo do Campo)',
  'parish',
  'latin',
  'BR',
  'active',
  1812,
  'Paróquia Catedral de Nossa Senhora da Boa Viagem (São Bernardo do Campo) localizada em São Bernardo do Campo, estado de São Paulo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Catedral de Nossa Senhora da Boa Viagem (São Bernardo do Campo)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-catedral-de-nossa-senhora-da-boa-viagem-sao-bernardo-do-campo-20'),
  'site-catedral-de-nossa-senhora-da-boa-viagem-sao-bernardo-do-campo-20',
  'Catedral de Nossa Senhora da Boa Viagem (São Bernardo do Campo)',
  'cathedral',
  'Praça da Matriz - Centro',
  'São Bernardo do Campo',
  'São Paulo',
  'BR',
  st_setsrid(st_makepoint(-46.5512, -23.7121), 4326)::geography,
  10,
  3,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Sagrada Família (São Caetano do Sul)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-sagrada-familia-sao-caetano-do-sul-21',
  'Paróquia Sagrada Família (São Caetano do Sul)',
  'parish',
  'latin',
  'BR',
  'active',
  1950,
  'Paróquia Paróquia Sagrada Família (São Caetano do Sul) localizada em São Caetano do Sul, estado de São Paulo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Paróquia Sagrada Família (São Caetano do Sul)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-sagrada-familia-sao-caetano-do-sul-21'),
  'site-paroquia-sagrada-familia-sao-caetano-do-sul-21',
  'Paróquia Sagrada Família (São Caetano do Sul)',
  'parish_church',
  'Praça Cardeal Arcoverde - Centro',
  'São Caetano do Sul',
  'São Paulo',
  'BR',
  st_setsrid(st_makepoint(-46.5712, -23.6182), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Catedral de Santo Antônio (Osasco)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-catedral-de-santo-antonio-osasco-22',
  'Catedral de Santo Antônio (Osasco)',
  'parish',
  'latin',
  'BR',
  'active',
  1930,
  'Paróquia Catedral de Santo Antônio (Osasco) localizada em Osasco, estado de São Paulo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Catedral de Santo Antônio (Osasco)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-catedral-de-santo-antonio-osasco-22'),
  'site-catedral-de-santo-antonio-osasco-22',
  'Catedral de Santo Antônio (Osasco)',
  'cathedral',
  'Av. Santo Antônio - Vila Osasco',
  'Osasco',
  'São Paulo',
  'BR',
  st_setsrid(st_makepoint(-46.7852, -23.5352), 4326)::geography,
  10,
  3,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Catedral de Nossa Senhora da Conceição (Guarulhos)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-catedral-de-nossa-senhora-da-conceicao-guarulhos-23',
  'Catedral de Nossa Senhora da Conceição (Guarulhos)',
  'parish',
  'latin',
  'BR',
  'active',
  1685,
  'Paróquia Catedral de Nossa Senhora da Conceição (Guarulhos) localizada em Guarulhos, estado de São Paulo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Catedral de Nossa Senhora da Conceição (Guarulhos)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-catedral-de-nossa-senhora-da-conceicao-guarulhos-23'),
  'site-catedral-de-nossa-senhora-da-conceicao-guarulhos-23',
  'Catedral de Nossa Senhora da Conceição (Guarulhos)',
  'cathedral',
  'Praça Tereza Cristina - Centro',
  'Guarulhos',
  'São Paulo',
  'BR',
  st_setsrid(st_makepoint(-46.5312, -23.4652), 4326)::geography,
  10,
  3,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Catedral de Santana (Mogi das Cruzes)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-catedral-de-santana-mogi-das-cruzes-24',
  'Catedral de Santana (Mogi das Cruzes)',
  'parish',
  'latin',
  'BR',
  'active',
  1611,
  'Paróquia Catedral de Santana (Mogi das Cruzes) localizada em Mogi das Cruzes, estado de São Paulo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Catedral de Santana (Mogi das Cruzes)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-catedral-de-santana-mogi-das-cruzes-24'),
  'site-catedral-de-santana-mogi-das-cruzes-24',
  'Catedral de Santana (Mogi das Cruzes)',
  'cathedral',
  'Praça Coronel Benedito de Almeida - Centro',
  'Mogi das Cruzes',
  'São Paulo',
  'BR',
  st_setsrid(st_makepoint(-46.1882, -23.5252), 4326)::geography,
  10,
  3,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Santuário Nacional de Nossa Senhora Aparecida (Basílica Nova)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-santuario-nacional-de-nossa-senhora-aparecida-basilica-nova-25',
  'Santuário Nacional de Nossa Senhora Aparecida (Basílica Nova)',
  'parish',
  'latin',
  'BR',
  'active',
  1717,
  'Paróquia Santuário Nacional de Nossa Senhora Aparecida (Basílica Nova) localizada em Aparecida, estado de São Paulo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Santuário Nacional de Nossa Senhora Aparecida (Basílica Nova)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-santuario-nacional-de-nossa-senhora-aparecida-basilica-nova-25'),
  'site-santuario-nacional-de-nossa-senhora-aparecida-basilica-nova-25',
  'Santuário Nacional de Nossa Senhora Aparecida (Basílica Nova)',
  'shrine',
  'Av. Dr. Júlio Prestes, s/n - Centro',
  'Aparecida',
  'São Paulo',
  'BR',
  st_setsrid(st_makepoint(-45.2341, -22.8497), 4326)::geography,
  10,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Basílica Histórica de Nossa Senhora Aparecida (Basílica Velha)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-basilica-historica-de-nossa-senhora-aparecida-basilica-velha-26',
  'Basílica Histórica de Nossa Senhora Aparecida (Basílica Velha)',
  'parish',
  'latin',
  'BR',
  'active',
  1745,
  'Paróquia Basílica Histórica de Nossa Senhora Aparecida (Basílica Velha) localizada em Aparecida, estado de São Paulo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Basílica Histórica de Nossa Senhora Aparecida (Basílica Velha)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-basilica-historica-de-nossa-senhora-aparecida-basilica-velha-26'),
  'site-basilica-historica-de-nossa-senhora-aparecida-basilica-velha-26',
  'Basílica Histórica de Nossa Senhora Aparecida (Basílica Velha)',
  'shrine',
  'Praça Nossa Senhora Aparecida - Centro',
  'Aparecida',
  'São Paulo',
  'BR',
  st_setsrid(st_makepoint(-45.2285, -22.8465), 4326)::geography,
  10,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Catedral de Santo Antônio (Guaratinguetá)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-catedral-de-santo-antonio-guaratingueta-27',
  'Catedral de Santo Antônio (Guaratinguetá)',
  'parish',
  'latin',
  'BR',
  'active',
  1630,
  'Paróquia Catedral de Santo Antônio (Guaratinguetá) localizada em Guaratinguetá, estado de São Paulo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Catedral de Santo Antônio (Guaratinguetá)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-catedral-de-santo-antonio-guaratingueta-27'),
  'site-catedral-de-santo-antonio-guaratingueta-27',
  'Catedral de Santo Antônio (Guaratinguetá)',
  'cathedral',
  'Praça Homero Ottoni - Centro',
  'Guaratinguetá',
  'São Paulo',
  'BR',
  st_setsrid(st_makepoint(-45.1912, -22.8162), 4326)::geography,
  10,
  3,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Santuário Frei Galvão (Guaratinguetá)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-santuario-frei-galvao-guaratingueta-28',
  'Santuário Frei Galvão (Guaratinguetá)',
  'parish',
  'latin',
  'BR',
  'active',
  2010,
  'Paróquia Santuário Frei Galvão (Guaratinguetá) localizada em Guaratinguetá, estado de São Paulo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Santuário Frei Galvão (Guaratinguetá)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-santuario-frei-galvao-guaratingueta-28'),
  'site-santuario-frei-galvao-guaratingueta-28',
  'Santuário Frei Galvão (Guaratinguetá)',
  'shrine',
  'Av. João Pessoa - Jardim das Filhas',
  'Guaratinguetá',
  'São Paulo',
  'BR',
  st_setsrid(st_makepoint(-45.1852, -22.8095), 4326)::geography,
  10,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Catedral de São José (São José dos Campos)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-catedral-de-sao-jose-sao-jose-dos-campos-29',
  'Catedral de São José (São José dos Campos)',
  'parish',
  'latin',
  'BR',
  'active',
  1934,
  'Paróquia Catedral de São José (São José dos Campos) localizada em São José dos Campos, estado de São Paulo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Catedral de São José (São José dos Campos)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-catedral-de-sao-jose-sao-jose-dos-campos-29'),
  'site-catedral-de-sao-jose-sao-jose-dos-campos-29',
  'Catedral de São José (São José dos Campos)',
  'cathedral',
  'Praça Afonso Pena - Centro',
  'São José dos Campos',
  'São Paulo',
  'BR',
  st_setsrid(st_makepoint(-45.8862, -23.1855), 4326)::geography,
  10,
  3,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Catedral de São Francisco das Chagas (Taubaté)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-catedral-de-sao-francisco-das-chagas-taubate-30',
  'Catedral de São Francisco das Chagas (Taubaté)',
  'parish',
  'latin',
  'BR',
  'active',
  1645,
  'Paróquia Catedral de São Francisco das Chagas (Taubaté) localizada em Taubaté, estado de São Paulo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Catedral de São Francisco das Chagas (Taubaté)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-catedral-de-sao-francisco-das-chagas-taubate-30'),
  'site-catedral-de-sao-francisco-das-chagas-taubate-30',
  'Catedral de São Francisco das Chagas (Taubaté)',
  'cathedral',
  'Praça Dom Epaminondas - Centro',
  'Taubaté',
  'São Paulo',
  'BR',
  st_setsrid(st_makepoint(-45.5582, -23.0252), 4326)::geography,
  10,
  3,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Catedral Metropolitana de Campinas
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-catedral-metropolitana-de-campinas-31',
  'Catedral Metropolitana de Campinas',
  'parish',
  'latin',
  'BR',
  'active',
  1807,
  'Paróquia Catedral Metropolitana de Campinas localizada em Campinas, estado de São Paulo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Catedral Metropolitana de Campinas
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-catedral-metropolitana-de-campinas-31'),
  'site-catedral-metropolitana-de-campinas-31',
  'Catedral Metropolitana de Campinas',
  'cathedral',
  'Praça Visconde de Indaiatuba - Centro',
  'Campinas',
  'São Paulo',
  'BR',
  st_setsrid(st_makepoint(-47.0608, -22.9055), 4326)::geography,
  10,
  3,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Nossa Senhora das Dores (Campinas - Cambuí)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-nossa-senhora-das-dores-campinas-cambui-32',
  'Paróquia Nossa Senhora das Dores (Campinas - Cambuí)',
  'parish',
  'latin',
  'BR',
  'active',
  1935,
  'Paróquia Paróquia Nossa Senhora das Dores (Campinas - Cambuí) localizada em Campinas, estado de São Paulo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Paróquia Nossa Senhora das Dores (Campinas - Cambuí)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-nossa-senhora-das-dores-campinas-cambui-32'),
  'site-paroquia-nossa-senhora-das-dores-campinas-cambui-32',
  'Paróquia Nossa Senhora das Dores (Campinas - Cambuí)',
  'parish_church',
  'R. Maria Monteiro - Cambuí',
  'Campinas',
  'São Paulo',
  'BR',
  st_setsrid(st_makepoint(-47.0512, -22.8982), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Catedral Nossa Senhora do Desterro (Jundiaí)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-catedral-nossa-senhora-do-desterro-jundiai-33',
  'Catedral Nossa Senhora do Desterro (Jundiaí)',
  'parish',
  'latin',
  'BR',
  'active',
  1651,
  'Paróquia Catedral Nossa Senhora do Desterro (Jundiaí) localizada em Jundiaí, estado de São Paulo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Catedral Nossa Senhora do Desterro (Jundiaí)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-catedral-nossa-senhora-do-desterro-jundiai-33'),
  'site-catedral-nossa-senhora-do-desterro-jundiai-33',
  'Catedral Nossa Senhora do Desterro (Jundiaí)',
  'cathedral',
  'Praça Gov. Pedro de Toledo - Centro',
  'Jundiaí',
  'São Paulo',
  'BR',
  st_setsrid(st_makepoint(-46.8842, -23.1862), 4326)::geography,
  10,
  3,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Igreja Matriz Nossa Senhora da Candelária (Itu)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-igreja-matriz-nossa-senhora-da-candelaria-itu-34',
  'Igreja Matriz Nossa Senhora da Candelária (Itu)',
  'parish',
  'latin',
  'BR',
  'active',
  1780,
  'Paróquia Igreja Matriz Nossa Senhora da Candelária (Itu) localizada em Itu, estado de São Paulo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz Nossa Senhora da Candelária (Itu)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-igreja-matriz-nossa-senhora-da-candelaria-itu-34'),
  'site-igreja-matriz-nossa-senhora-da-candelaria-itu-34',
  'Igreja Matriz Nossa Senhora da Candelária (Itu)',
  'parish_church',
  'Praça Padre Miguel - Centro',
  'Itu',
  'São Paulo',
  'BR',
  st_setsrid(st_makepoint(-47.2985, -23.2642), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Santo Antônio (Piracicaba)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-santo-antonio-piracicaba-35',
  'Paróquia Santo Antônio (Piracicaba)',
  'parish',
  'latin',
  'BR',
  'active',
  1774,
  'Paróquia Paróquia Santo Antônio (Piracicaba) localizada em Piracicaba, estado de São Paulo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Paróquia Santo Antônio (Piracicaba)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-santo-antonio-piracicaba-35'),
  'site-paroquia-santo-antonio-piracicaba-35',
  'Paróquia Santo Antônio (Piracicaba)',
  'cathedral',
  'Praça José Bonifácio - Centro',
  'Piracicaba',
  'São Paulo',
  'BR',
  st_setsrid(st_makepoint(-47.6482, -22.7252), 4326)::geography,
  10,
  3,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Nossa Senhora das Dores (Limeira)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-nossa-senhora-das-dores-limeira-36',
  'Paróquia Nossa Senhora das Dores (Limeira)',
  'parish',
  'latin',
  'BR',
  'active',
  1826,
  'Paróquia Paróquia Nossa Senhora das Dores (Limeira) localizada em Limeira, estado de São Paulo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Paróquia Nossa Senhora das Dores (Limeira)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-nossa-senhora-das-dores-limeira-36'),
  'site-paroquia-nossa-senhora-das-dores-limeira-36',
  'Paróquia Nossa Senhora das Dores (Limeira)',
  'cathedral',
  'Praça Toledo Barros - Centro',
  'Limeira',
  'São Paulo',
  'BR',
  st_setsrid(st_makepoint(-47.4012, -22.5652), 4326)::geography,
  10,
  3,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Nossa Senhora da Conceição (Bragança Paulista)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-nossa-senhora-da-conceicao-braganca-paulista-37',
  'Paróquia Nossa Senhora da Conceição (Bragança Paulista)',
  'parish',
  'latin',
  'BR',
  'active',
  1765,
  'Paróquia Paróquia Nossa Senhora da Conceição (Bragança Paulista) localizada em Bragança Paulista, estado de São Paulo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Paróquia Nossa Senhora da Conceição (Bragança Paulista)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-nossa-senhora-da-conceicao-braganca-paulista-37'),
  'site-paroquia-nossa-senhora-da-conceicao-braganca-paulista-37',
  'Paróquia Nossa Senhora da Conceição (Bragança Paulista)',
  'cathedral',
  'Praça Raul Leme - Centro',
  'Bragança Paulista',
  'São Paulo',
  'BR',
  st_setsrid(st_makepoint(-46.5412, -22.9552), 4326)::geography,
  10,
  3,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Catedral Metropolitana São Sebastião (Ribeirão Preto)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-catedral-metropolitana-sao-sebastiao-ribeirao-preto-38',
  'Catedral Metropolitana São Sebastião (Ribeirão Preto)',
  'parish',
  'latin',
  'BR',
  'active',
  1904,
  'Paróquia Catedral Metropolitana São Sebastião (Ribeirão Preto) localizada em Ribeirão Preto, estado de São Paulo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Catedral Metropolitana São Sebastião (Ribeirão Preto)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-catedral-metropolitana-sao-sebastiao-ribeirao-preto-38'),
  'site-catedral-metropolitana-sao-sebastiao-ribeirao-preto-38',
  'Catedral Metropolitana São Sebastião (Ribeirão Preto)',
  'cathedral',
  'Praça das Bandeiras - Centro',
  'Ribeirão Preto',
  'São Paulo',
  'BR',
  st_setsrid(st_makepoint(-47.8102, -21.1772), 4326)::geography,
  10,
  3,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Santuário de Nossa Senhora do Rosário (Ribeirão)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-santuario-de-nossa-senhora-do-rosario-ribeirao-39',
  'Paróquia Santuário de Nossa Senhora do Rosário (Ribeirão)',
  'parish',
  'latin',
  'BR',
  'active',
  1920,
  'Paróquia Paróquia Santuário de Nossa Senhora do Rosário (Ribeirão) localizada em Ribeirão Preto, estado de São Paulo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Paróquia Santuário de Nossa Senhora do Rosário (Ribeirão)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-santuario-de-nossa-senhora-do-rosario-ribeirao-39'),
  'site-paroquia-santuario-de-nossa-senhora-do-rosario-ribeirao-39',
  'Paróquia Santuário de Nossa Senhora do Rosário (Ribeirão)',
  'shrine',
  'R. Martinico Prado - Vila Tibério',
  'Ribeirão Preto',
  'São Paulo',
  'BR',
  st_setsrid(st_makepoint(-47.8152, -21.1712), 4326)::geography,
  10,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Catedral São Carlos Borromeu (São Carlos)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-catedral-sao-carlos-borromeu-sao-carlos-40',
  'Catedral São Carlos Borromeu (São Carlos)',
  'parish',
  'latin',
  'BR',
  'active',
  1956,
  'Paróquia Catedral São Carlos Borromeu (São Carlos) localizada em São Carlos, estado de São Paulo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Catedral São Carlos Borromeu (São Carlos)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-catedral-sao-carlos-borromeu-sao-carlos-40'),
  'site-catedral-sao-carlos-borromeu-sao-carlos-40',
  'Catedral São Carlos Borromeu (São Carlos)',
  'cathedral',
  'Praça Dom José Marcondes - Centro',
  'São Carlos',
  'São Paulo',
  'BR',
  st_setsrid(st_makepoint(-47.8912, -22.0182), 4326)::geography,
  10,
  3,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Catedral de Nossa Senhora do Carmo (Jaboticabal)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-catedral-de-nossa-senhora-do-carmo-jaboticabal-41',
  'Catedral de Nossa Senhora do Carmo (Jaboticabal)',
  'parish',
  'latin',
  'BR',
  'active',
  1828,
  'Paróquia Catedral de Nossa Senhora do Carmo (Jaboticabal) localizada em Jaboticabal, estado de São Paulo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Catedral de Nossa Senhora do Carmo (Jaboticabal)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-catedral-de-nossa-senhora-do-carmo-jaboticabal-41'),
  'site-catedral-de-nossa-senhora-do-carmo-jaboticabal-41',
  'Catedral de Nossa Senhora do Carmo (Jaboticabal)',
  'cathedral',
  'Praça Dom José Marcondes - Centro',
  'Jaboticabal',
  'São Paulo',
  'BR',
  st_setsrid(st_makepoint(-48.3182, -21.2552), 4326)::geography,
  10,
  3,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Catedral de São Bento (Araraquara)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-catedral-de-sao-bento-araraquara-42',
  'Catedral de São Bento (Araraquara)',
  'parish',
  'latin',
  'BR',
  'active',
  1817,
  'Paróquia Catedral de São Bento (Araraquara) localizada em Araraquara, estado de São Paulo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Catedral de São Bento (Araraquara)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-catedral-de-sao-bento-araraquara-42'),
  'site-catedral-de-sao-bento-araraquara-42',
  'Catedral de São Bento (Araraquara)',
  'cathedral',
  'Praça da Matriz - Centro',
  'Araraquara',
  'São Paulo',
  'BR',
  st_setsrid(st_makepoint(-48.1752, -21.7952), 4326)::geography,
  10,
  3,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Catedral de Divino Espírito Santo (Barretos)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-catedral-de-divino-espirito-santo-barretos-43',
  'Catedral de Divino Espírito Santo (Barretos)',
  'parish',
  'latin',
  'BR',
  'active',
  1877,
  'Paróquia Catedral de Divino Espírito Santo (Barretos) localizada em Barretos, estado de São Paulo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Catedral de Divino Espírito Santo (Barretos)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-catedral-de-divino-espirito-santo-barretos-43'),
  'site-catedral-de-divino-espirito-santo-barretos-43',
  'Catedral de Divino Espírito Santo (Barretos)',
  'cathedral',
  'Praça Francisco Barreto - Centro',
  'Barretos',
  'São Paulo',
  'BR',
  st_setsrid(st_makepoint(-48.5682, -20.5582), 4326)::geography,
  10,
  3,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Catedral Nossa Senhora do Rosário (Santos)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-catedral-nossa-senhora-do-rosario-santos-44',
  'Catedral Nossa Senhora do Rosário (Santos)',
  'parish',
  'latin',
  'BR',
  'active',
  1909,
  'Paróquia Catedral Nossa Senhora do Rosário (Santos) localizada em Santos, estado de São Paulo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Catedral Nossa Senhora do Rosário (Santos)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-catedral-nossa-senhora-do-rosario-santos-44'),
  'site-catedral-nossa-senhora-do-rosario-santos-44',
  'Catedral Nossa Senhora do Rosário (Santos)',
  'cathedral',
  'Praça José Bonifácio - Centro',
  'Santos',
  'São Paulo',
  'BR',
  st_setsrid(st_makepoint(-46.3282, -23.9352), 4326)::geography,
  10,
  3,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Santuário de Santo Antônio do Valongo
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-santuario-de-santo-antonio-do-valongo-45',
  'Santuário de Santo Antônio do Valongo',
  'parish',
  'latin',
  'BR',
  'active',
  1640,
  'Paróquia Santuário de Santo Antônio do Valongo localizada em Santos, estado de São Paulo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Santuário de Santo Antônio do Valongo
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-santuario-de-santo-antonio-do-valongo-45'),
  'site-santuario-de-santo-antonio-do-valongo-45',
  'Santuário de Santo Antônio do Valongo',
  'shrine',
  'Largo Marquês de Monte Alegre - Valongo',
  'Santos',
  'São Paulo',
  'BR',
  st_setsrid(st_makepoint(-46.3332, -23.9312), 4326)::geography,
  10,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Igreja Matriz São Vicente Martir (São Vicente)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-igreja-matriz-sao-vicente-martir-sao-vicente-46',
  'Igreja Matriz São Vicente Martir (São Vicente)',
  'parish',
  'latin',
  'BR',
  'active',
  1532,
  'Paróquia Igreja Matriz São Vicente Martir (São Vicente) localizada em São Vicente, estado de São Paulo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Igreja Matriz São Vicente Martir (São Vicente)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-igreja-matriz-sao-vicente-martir-sao-vicente-46'),
  'site-igreja-matriz-sao-vicente-martir-sao-vicente-46',
  'Igreja Matriz São Vicente Martir (São Vicente)',
  'parish_church',
  'Praça João Pessoa - Centro',
  'São Vicente',
  'São Paulo',
  'BR',
  st_setsrid(st_makepoint(-46.3882, -23.9678), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia Nossa Senhora das Dores (Ubatuba)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-nossa-senhora-das-dores-ubatuba-47',
  'Paróquia Nossa Senhora das Dores (Ubatuba)',
  'parish',
  'latin',
  'BR',
  'active',
  1637,
  'Paróquia Paróquia Nossa Senhora das Dores (Ubatuba) localizada em Ubatuba, estado de São Paulo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Paróquia Nossa Senhora das Dores (Ubatuba)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-nossa-senhora-das-dores-ubatuba-47'),
  'site-paroquia-nossa-senhora-das-dores-ubatuba-47',
  'Paróquia Nossa Senhora das Dores (Ubatuba)',
  'parish_church',
  'Praça Exaltação à Santa Cruz - Centro',
  'Ubatuba',
  'São Paulo',
  'BR',
  st_setsrid(st_makepoint(-45.0712, -23.4332), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

-- Jurisdiction: Paróquia São Sebastião (São Sebastião)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-sao-sebastiao-sao-sebastiao-48',
  'Paróquia São Sebastião (São Sebastião)',
  'parish',
  'latin',
  'BR',
  'active',
  1636,
  'Paróquia Paróquia São Sebastião (São Sebastião) localizada em São Sebastião, estado de São Paulo.',
  true
)
on conflict (slug) do update set
  name = excluded.name,
  canonical_type = excluded.canonical_type,
  tradition = excluded.tradition,
  country_code = excluded.country_code,
  status = excluded.status,
  erected_year = excluded.erected_year,
  description = excluded.description,
  updated_at = now();
-- Site: Paróquia São Sebastião (São Sebastião)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-sao-sebastiao-sao-sebastiao-48'),
  'site-paroquia-sao-sebastiao-sao-sebastiao-48',
  'Paróquia São Sebastião (São Sebastião)',
  'parish_church',
  'Praça Major João Fernandes - Centro',
  'São Sebastião',
  'São Paulo',
  'BR',
  st_setsrid(st_makepoint(-45.4012, -23.7982), 4326)::geography,
  11,
  4,
  true,
  true
)
on conflict (slug) do update set
  name = excluded.name,
  site_type = excluded.site_type,
  address = excluded.address,
  locality = excluded.locality,
  admin_area = excluded.admin_area,
  location = excluded.location,
  min_zoom = excluded.min_zoom,
  display_rank = excluded.display_rank,
  updated_at = now();

commit;
