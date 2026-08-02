-- Sancta Historia
-- Migração de Paróquias gerada automaticamente a partir de supabase/data/parishes/BR/RJ.json
-- Operação idempotente via ON CONFLICT (slug) DO UPDATE

begin;

-- Jurisdiction: Catedral Metropolitana de São Sebastião
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-catedral-metropolitana-de-sao-sebastiao-0',
  'Catedral Metropolitana de São Sebastião',
  'parish',
  'latin',
  'BR',
  'active',
  1676,
  'Paróquia Catedral Metropolitana de São Sebastião localizada em Rio de Janeiro, estado do Rio de Janeiro.',
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
-- Site: Catedral Metropolitana de São Sebastião
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-catedral-metropolitana-de-sao-sebastiao-0'),
  'site-catedral-metropolitana-de-sao-sebastiao-0',
  'Catedral Metropolitana de São Sebastião',
  'cathedral',
  'Av. Chile, 245 - Centro',
  'Rio de Janeiro',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-43.1806, -22.9108), 4326)::geography,
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

-- Jurisdiction: Igreja da Candelária (Nossa Senhora da Candelária)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-igreja-da-candelaria-nossa-senhora-da-candelaria-1',
  'Igreja da Candelária (Nossa Senhora da Candelária)',
  'parish',
  'latin',
  'BR',
  'active',
  1609,
  'Paróquia Igreja da Candelária (Nossa Senhora da Candelária) localizada em Rio de Janeiro, estado do Rio de Janeiro.',
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
-- Site: Igreja da Candelária (Nossa Senhora da Candelária)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-igreja-da-candelaria-nossa-senhora-da-candelaria-1'),
  'site-igreja-da-candelaria-nossa-senhora-da-candelaria-1',
  'Igreja da Candelária (Nossa Senhora da Candelária)',
  'parish_church',
  'Praça Pio X, s/n - Centro',
  'Rio de Janeiro',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-43.1775, -22.9008), 4326)::geography,
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

-- Jurisdiction: Santuário de Nossa Senhora da Penha
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-santuario-de-nossa-senhora-da-penha-2',
  'Santuário de Nossa Senhora da Penha',
  'parish',
  'latin',
  'BR',
  'active',
  1635,
  'Paróquia Santuário de Nossa Senhora da Penha localizada em Rio de Janeiro, estado do Rio de Janeiro.',
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
-- Site: Santuário de Nossa Senhora da Penha
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-santuario-de-nossa-senhora-da-penha-2'),
  'site-santuario-de-nossa-senhora-da-penha-2',
  'Santuário de Nossa Senhora da Penha',
  'shrine',
  'Praça Nossa Senhora da Penha, s/n - Penha',
  'Rio de Janeiro',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-43.2778, -22.8447), 4326)::geography,
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

-- Jurisdiction: Igreja de Nossa Senhora da Glória do Outeiro
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-igreja-de-nossa-senhora-da-gloria-do-outeiro-3',
  'Igreja de Nossa Senhora da Glória do Outeiro',
  'parish',
  'latin',
  'BR',
  'active',
  1739,
  'Paróquia Igreja de Nossa Senhora da Glória do Outeiro localizada em Rio de Janeiro, estado do Rio de Janeiro.',
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
-- Site: Igreja de Nossa Senhora da Glória do Outeiro
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-igreja-de-nossa-senhora-da-gloria-do-outeiro-3'),
  'site-igreja-de-nossa-senhora-da-gloria-do-outeiro-3',
  'Igreja de Nossa Senhora da Glória do Outeiro',
  'shrine',
  'Praça N. Sra. da Glória, 135 - Glória',
  'Rio de Janeiro',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-43.1739, -22.9211), 4326)::geography,
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

-- Jurisdiction: Paróquia São José (Centro)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-sao-jose-centro-4',
  'Paróquia São José (Centro)',
  'parish',
  'latin',
  'BR',
  'active',
  1608,
  'Paróquia Paróquia São José (Centro) localizada em Rio de Janeiro, estado do Rio de Janeiro.',
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
-- Site: Paróquia São José (Centro)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-sao-jose-centro-4'),
  'site-paroquia-sao-jose-centro-4',
  'Paróquia São José (Centro)',
  'parish_church',
  'Av. Pres. Antônio Carlos, s/n - Centro',
  'Rio de Janeiro',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-43.1728, -22.9042), 4326)::geography,
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

-- Jurisdiction: Paróquia Nossa Senhora de Copacabana
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-nossa-senhora-de-copacabana-5',
  'Paróquia Nossa Senhora de Copacabana',
  'parish',
  'latin',
  'BR',
  'active',
  1908,
  'Paróquia Paróquia Nossa Senhora de Copacabana localizada em Rio de Janeiro, estado do Rio de Janeiro.',
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
-- Site: Paróquia Nossa Senhora de Copacabana
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-nossa-senhora-de-copacabana-5'),
  'site-paroquia-nossa-senhora-de-copacabana-5',
  'Paróquia Nossa Senhora de Copacabana',
  'parish_church',
  'R. Hilário de Gouveia, 36 - Copacabana',
  'Rio de Janeiro',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-43.1838, -22.9691), 4326)::geography,
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

-- Jurisdiction: Paróquia Nossa Senhora da Paz
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-nossa-senhora-da-paz-6',
  'Paróquia Nossa Senhora da Paz',
  'parish',
  'latin',
  'BR',
  'active',
  1918,
  'Paróquia Paróquia Nossa Senhora da Paz localizada em Rio de Janeiro, estado do Rio de Janeiro.',
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
-- Site: Paróquia Nossa Senhora da Paz
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-nossa-senhora-da-paz-6'),
  'site-paroquia-nossa-senhora-da-paz-6',
  'Paróquia Nossa Senhora da Paz',
  'parish_church',
  'R. Visconde de Pirajá, 339 - Ipanema',
  'Rio de Janeiro',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-43.2045, -22.9839), 4326)::geography,
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

-- Jurisdiction: Paróquia São Francisco Xavier
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-sao-francisco-xavier-7',
  'Paróquia São Francisco Xavier',
  'parish',
  'latin',
  'BR',
  'active',
  1568,
  'Paróquia Paróquia São Francisco Xavier localizada em Rio de Janeiro, estado do Rio de Janeiro.',
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
-- Site: Paróquia São Francisco Xavier
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-sao-francisco-xavier-7'),
  'site-paroquia-sao-francisco-xavier-7',
  'Paróquia São Francisco Xavier',
  'parish_church',
  'R. São Francisco Xavier, 75 - Tijuca',
  'Rio de Janeiro',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-43.2241, -22.9189), 4326)::geography,
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

-- Jurisdiction: Paróquia Nossa Senhora da Conceição (Santa Cruz)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-nossa-senhora-da-conceicao-santa-cruz-8',
  'Paróquia Nossa Senhora da Conceição (Santa Cruz)',
  'parish',
  'latin',
  'BR',
  'active',
  1567,
  'Paróquia Paróquia Nossa Senhora da Conceição (Santa Cruz) localizada em Rio de Janeiro, estado do Rio de Janeiro.',
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
-- Site: Paróquia Nossa Senhora da Conceição (Santa Cruz)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-nossa-senhora-da-conceicao-santa-cruz-8'),
  'site-paroquia-nossa-senhora-da-conceicao-santa-cruz-8',
  'Paróquia Nossa Senhora da Conceição (Santa Cruz)',
  'parish_church',
  'Praça Fernando Barata Ribeiro - Santa Cruz',
  'Rio de Janeiro',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-43.6845, -22.9158), 4326)::geography,
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

-- Jurisdiction: Paróquia São João Batista (Botafogo)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-sao-joao-batista-botafogo-9',
  'Paróquia São João Batista (Botafogo)',
  'parish',
  'latin',
  'BR',
  'active',
  1809,
  'Paróquia Paróquia São João Batista (Botafogo) localizada em Rio de Janeiro, estado do Rio de Janeiro.',
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
-- Site: Paróquia São João Batista (Botafogo)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-sao-joao-batista-botafogo-9'),
  'site-paroquia-sao-joao-batista-botafogo-9',
  'Paróquia São João Batista (Botafogo)',
  'parish_church',
  'R. Voluntários da Pátria, 287 - Botafogo',
  'Rio de Janeiro',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-43.1915, -22.956), 4326)::geography,
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

-- Jurisdiction: Paróquia Santuário de São Judas Tadeu
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-santuario-de-sao-judas-tadeu-10',
  'Paróquia Santuário de São Judas Tadeu',
  'parish',
  'latin',
  'BR',
  'active',
  1945,
  'Paróquia Paróquia Santuário de São Judas Tadeu localizada em Rio de Janeiro, estado do Rio de Janeiro.',
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
-- Site: Paróquia Santuário de São Judas Tadeu
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-santuario-de-sao-judas-tadeu-10'),
  'site-paroquia-santuario-de-sao-judas-tadeu-10',
  'Paróquia Santuário de São Judas Tadeu',
  'shrine',
  'R. Cosme Velho, 290 - Cosme Velho',
  'Rio de Janeiro',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-43.2001, -22.9412), 4326)::geography,
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

-- Jurisdiction: Paróquia Nossa Senhora da Conceição (Gávea)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-nossa-senhora-da-conceicao-gavea-11',
  'Paróquia Nossa Senhora da Conceição (Gávea)',
  'parish',
  'latin',
  'BR',
  'active',
  1853,
  'Paróquia Paróquia Nossa Senhora da Conceição (Gávea) localizada em Rio de Janeiro, estado do Rio de Janeiro.',
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
-- Site: Paróquia Nossa Senhora da Conceição (Gávea)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-nossa-senhora-da-conceicao-gavea-11'),
  'site-paroquia-nossa-senhora-da-conceicao-gavea-11',
  'Paróquia Nossa Senhora da Conceição (Gávea)',
  'parish_church',
  'R. Marquês de São Vicente, 19 - Gávea',
  'Rio de Janeiro',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-43.2268, -22.9745), 4326)::geography,
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

-- Jurisdiction: Paróquia São José da Lagoa
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-sao-jose-da-lagoa-12',
  'Paróquia São José da Lagoa',
  'parish',
  'latin',
  'BR',
  'active',
  1942,
  'Paróquia Paróquia São José da Lagoa localizada em Rio de Janeiro, estado do Rio de Janeiro.',
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
-- Site: Paróquia São José da Lagoa
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-sao-jose-da-lagoa-12'),
  'site-paroquia-sao-jose-da-lagoa-12',
  'Paróquia São José da Lagoa',
  'parish_church',
  'Av. Borges de Medeiros, 2735 - Lagoa',
  'Rio de Janeiro',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-43.212, -22.9712), 4326)::geography,
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

-- Jurisdiction: Paróquia Nossa Senhora da Apresentação (Irajá)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-nossa-senhora-da-apresentacao-iraja-13',
  'Paróquia Nossa Senhora da Apresentação (Irajá)',
  'parish',
  'latin',
  'BR',
  'active',
  1644,
  'Paróquia Paróquia Nossa Senhora da Apresentação (Irajá) localizada em Rio de Janeiro, estado do Rio de Janeiro.',
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
-- Site: Paróquia Nossa Senhora da Apresentação (Irajá)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-nossa-senhora-da-apresentacao-iraja-13'),
  'site-paroquia-nossa-senhora-da-apresentacao-iraja-13',
  'Paróquia Nossa Senhora da Apresentação (Irajá)',
  'parish_church',
  'Praça N. Sra. da Apresentação - Irajá',
  'Rio de Janeiro',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-43.3285, -22.834), 4326)::geography,
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

-- Jurisdiction: Paróquia Nossa Senhora de Loreto (Freguesia)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-nossa-senhora-de-loreto-freguesia-14',
  'Paróquia Nossa Senhora de Loreto (Freguesia)',
  'parish',
  'latin',
  'BR',
  'active',
  1661,
  'Paróquia Paróquia Nossa Senhora de Loreto (Freguesia) localizada em Rio de Janeiro, estado do Rio de Janeiro.',
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
-- Site: Paróquia Nossa Senhora de Loreto (Freguesia)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-nossa-senhora-de-loreto-freguesia-14'),
  'site-paroquia-nossa-senhora-de-loreto-freguesia-14',
  'Paróquia Nossa Senhora de Loreto (Freguesia)',
  'parish_church',
  'Largo do Loreto, 55 - Jacarepaguá',
  'Rio de Janeiro',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-43.3421, -22.9421), 4326)::geography,
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

-- Jurisdiction: Paróquia São Sebastião (Bangu)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-sao-sebastiao-bangu-15',
  'Paróquia São Sebastião (Bangu)',
  'parish',
  'latin',
  'BR',
  'active',
  1908,
  'Paróquia Paróquia São Sebastião (Bangu) localizada em Rio de Janeiro, estado do Rio de Janeiro.',
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
-- Site: Paróquia São Sebastião (Bangu)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-sao-sebastiao-bangu-15'),
  'site-paroquia-sao-sebastiao-bangu-15',
  'Paróquia São Sebastião (Bangu)',
  'parish_church',
  'R. Silva Cardoso, 715 - Bangu',
  'Rio de Janeiro',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-43.4682, -22.8752), 4326)::geography,
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

-- Jurisdiction: Paróquia Nossa Senhora da Conceição (Campo Grande)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-nossa-senhora-da-conceicao-campo-grande-16',
  'Paróquia Nossa Senhora da Conceição (Campo Grande)',
  'parish',
  'latin',
  'BR',
  'active',
  1673,
  'Paróquia Paróquia Nossa Senhora da Conceição (Campo Grande) localizada em Rio de Janeiro, estado do Rio de Janeiro.',
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
-- Site: Paróquia Nossa Senhora da Conceição (Campo Grande)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-nossa-senhora-da-conceicao-campo-grande-16'),
  'site-paroquia-nossa-senhora-da-conceicao-campo-grande-16',
  'Paróquia Nossa Senhora da Conceição (Campo Grande)',
  'parish_church',
  'Praça Dom José de Camargo - Campo Grande',
  'Rio de Janeiro',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-43.5582, -22.9032), 4326)::geography,
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

-- Jurisdiction: Paróquia São Francisco de Assis (Barra da Tijuca)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-sao-francisco-de-assis-barra-da-tijuca-17',
  'Paróquia São Francisco de Assis (Barra da Tijuca)',
  'parish',
  'latin',
  'BR',
  'active',
  1985,
  'Paróquia Paróquia São Francisco de Assis (Barra da Tijuca) localizada em Rio de Janeiro, estado do Rio de Janeiro.',
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
-- Site: Paróquia São Francisco de Assis (Barra da Tijuca)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-sao-francisco-de-assis-barra-da-tijuca-17'),
  'site-paroquia-sao-francisco-de-assis-barra-da-tijuca-17',
  'Paróquia São Francisco de Assis (Barra da Tijuca)',
  'parish_church',
  'Av. Ayrton Senna, 3000 - Barra da Tijuca',
  'Rio de Janeiro',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-43.3285, -23.0012), 4326)::geography,
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

-- Jurisdiction: Paróquia Ressurreição (Arpoador)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-ressurreicao-arpoador-18',
  'Paróquia Ressurreição (Arpoador)',
  'parish',
  'latin',
  'BR',
  'active',
  1962,
  'Paróquia Paróquia Ressurreição (Arpoador) localizada em Rio de Janeiro, estado do Rio de Janeiro.',
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
-- Site: Paróquia Ressurreição (Arpoador)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-ressurreicao-arpoador-18'),
  'site-paroquia-ressurreicao-arpoador-18',
  'Paróquia Ressurreição (Arpoador)',
  'parish_church',
  'R. Francisco Otaviano, 99 - Copacabana',
  'Rio de Janeiro',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-43.1932, -22.9868), 4326)::geography,
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

-- Jurisdiction: Paróquia Santa Teresa de Jesus
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-santa-teresa-de-jesus-19',
  'Paróquia Santa Teresa de Jesus',
  'parish',
  'latin',
  'BR',
  'active',
  1910,
  'Paróquia Paróquia Santa Teresa de Jesus localizada em Rio de Janeiro, estado do Rio de Janeiro.',
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
-- Site: Paróquia Santa Teresa de Jesus
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-santa-teresa-de-jesus-19'),
  'site-paroquia-santa-teresa-de-jesus-19',
  'Paróquia Santa Teresa de Jesus',
  'parish_church',
  'R. Monte Alegre, 347 - Santa Teresa',
  'Rio de Janeiro',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-43.1852, -22.9152), 4326)::geography,
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

-- Jurisdiction: Paróquia São Lourenço dos Índios
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-sao-lourenco-dos-indios-20',
  'Paróquia São Lourenço dos Índios',
  'parish',
  'latin',
  'BR',
  'active',
  1573,
  'Paróquia Paróquia São Lourenço dos Índios localizada em Niterói, estado do Rio de Janeiro.',
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
-- Site: Paróquia São Lourenço dos Índios
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-sao-lourenco-dos-indios-20'),
  'site-paroquia-sao-lourenco-dos-indios-20',
  'Paróquia São Lourenço dos Índios',
  'shrine',
  'Morro de São Lourenço - Niterói',
  'Niterói',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-43.1092, -22.8812), 4326)::geography,
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

-- Jurisdiction: Catedral Metropolitana São João Batista
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-catedral-metropolitana-sao-joao-batista-21',
  'Catedral Metropolitana São João Batista',
  'parish',
  'latin',
  'BR',
  'active',
  1842,
  'Paróquia Catedral Metropolitana São João Batista localizada em Niterói, estado do Rio de Janeiro.',
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
-- Site: Catedral Metropolitana São João Batista
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-catedral-metropolitana-sao-joao-batista-21'),
  'site-catedral-metropolitana-sao-joao-batista-21',
  'Catedral Metropolitana São João Batista',
  'cathedral',
  'Praça Dom Pedro II, s/n - Centro',
  'Niterói',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-43.1228, -22.8905), 4326)::geography,
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

-- Jurisdiction: Paróquia São Francisco Xavier
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-sao-francisco-xavier-22',
  'Paróquia São Francisco Xavier',
  'parish',
  'latin',
  'BR',
  'active',
  1570,
  'Paróquia Paróquia São Francisco Xavier localizada em Niterói, estado do Rio de Janeiro.',
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
-- Site: Paróquia São Francisco Xavier
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-sao-francisco-xavier-22'),
  'site-paroquia-sao-francisco-xavier-22',
  'Paróquia São Francisco Xavier',
  'parish_church',
  'Av. Quintino Bocaiúva - São Francisco',
  'Niterói',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-43.0945, -22.923), 4326)::geography,
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

-- Jurisdiction: Paróquia Nossa Senhora das Dores (Ingá)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-nossa-senhora-das-dores-inga-23',
  'Paróquia Nossa Senhora das Dores (Ingá)',
  'parish',
  'latin',
  'BR',
  'active',
  1920,
  'Paróquia Paróquia Nossa Senhora das Dores (Ingá) localizada em Niterói, estado do Rio de Janeiro.',
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
-- Site: Paróquia Nossa Senhora das Dores (Ingá)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-nossa-senhora-das-dores-inga-23'),
  'site-paroquia-nossa-senhora-das-dores-inga-23',
  'Paróquia Nossa Senhora das Dores (Ingá)',
  'parish_church',
  'R. Dr. Paulo Alves, 12 - Ingá',
  'Niterói',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-43.1252, -22.9012), 4326)::geography,
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

-- Jurisdiction: Paróquia Nossa Senhora da Conceição (Icaraí)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-nossa-senhora-da-conceicao-icarai-24',
  'Paróquia Nossa Senhora da Conceição (Icaraí)',
  'parish',
  'latin',
  'BR',
  'active',
  1935,
  'Paróquia Paróquia Nossa Senhora da Conceição (Icaraí) localizada em Niterói, estado do Rio de Janeiro.',
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
-- Site: Paróquia Nossa Senhora da Conceição (Icaraí)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-nossa-senhora-da-conceicao-icarai-24'),
  'site-paroquia-nossa-senhora-da-conceicao-icarai-24',
  'Paróquia Nossa Senhora da Conceição (Icaraí)',
  'parish_church',
  'R. Gavião Peixoto, 250 - Icaraí',
  'Niterói',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-43.1082, -22.9052), 4326)::geography,
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

-- Jurisdiction: Paróquia São Gonçalo do Amarante
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-sao-goncalo-do-amarante-25',
  'Paróquia São Gonçalo do Amarante',
  'parish',
  'latin',
  'BR',
  'active',
  1646,
  'Paróquia Paróquia São Gonçalo do Amarante localizada em São Gonçalo, estado do Rio de Janeiro.',
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
-- Site: Paróquia São Gonçalo do Amarante
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-sao-goncalo-do-amarante-25'),
  'site-paroquia-sao-goncalo-do-amarante-25',
  'Paróquia São Gonçalo do Amarante',
  'parish_church',
  'Alameda Pio XII, s/n - Zé Garoto',
  'São Gonçalo',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-43.0542, -22.8251), 4326)::geography,
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

-- Jurisdiction: Paróquia Nossa Senhora da Conceição (Porto Velho)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-nossa-senhora-da-conceicao-porto-velho-26',
  'Paróquia Nossa Senhora da Conceição (Porto Velho)',
  'parish',
  'latin',
  'BR',
  'active',
  1950,
  'Paróquia Paróquia Nossa Senhora da Conceição (Porto Velho) localizada em São Gonçalo, estado do Rio de Janeiro.',
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
-- Site: Paróquia Nossa Senhora da Conceição (Porto Velho)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-nossa-senhora-da-conceicao-porto-velho-26'),
  'site-paroquia-nossa-senhora-da-conceicao-porto-velho-26',
  'Paróquia Nossa Senhora da Conceição (Porto Velho)',
  'parish_church',
  'R. Dr. Gradim - Porto Velho',
  'São Gonçalo',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-43.0652, -22.8121), 4326)::geography,
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

-- Jurisdiction: Paróquia São João Batista (Itaboraí)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-sao-joao-batista-itaborai-27',
  'Paróquia São João Batista (Itaboraí)',
  'parish',
  'latin',
  'BR',
  'active',
  1672,
  'Paróquia Paróquia São João Batista (Itaboraí) localizada em Itaboraí, estado do Rio de Janeiro.',
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
-- Site: Paróquia São João Batista (Itaboraí)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-sao-joao-batista-itaborai-27'),
  'site-paroquia-sao-joao-batista-itaborai-27',
  'Paróquia São João Batista (Itaboraí)',
  'parish_church',
  'Praça Marechal Floriano Peixoto - Centro',
  'Itaboraí',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-42.8582, -22.7452), 4326)::geography,
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

-- Jurisdiction: Paróquia Nossa Senhora do Amparo (Maricá)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-nossa-senhora-do-amparo-marica-28',
  'Paróquia Nossa Senhora do Amparo (Maricá)',
  'parish',
  'latin',
  'BR',
  'active',
  1788,
  'Paróquia Paróquia Nossa Senhora do Amparo (Maricá) localizada em Maricá, estado do Rio de Janeiro.',
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
-- Site: Paróquia Nossa Senhora do Amparo (Maricá)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-nossa-senhora-do-amparo-marica-28'),
  'site-paroquia-nossa-senhora-do-amparo-marica-28',
  'Paróquia Nossa Senhora do Amparo (Maricá)',
  'parish_church',
  'Praça Orlando de Barros Pimentel - Centro',
  'Maricá',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-42.8188, -22.9192), 4326)::geography,
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

-- Jurisdiction: Paróquia Nossa Senhora da Conceição (Saquarema)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-nossa-senhora-da-conceicao-saquarema-29',
  'Paróquia Nossa Senhora da Conceição (Saquarema)',
  'parish',
  'latin',
  'BR',
  'active',
  1755,
  'Paróquia Paróquia Nossa Senhora da Conceição (Saquarema) localizada em Saquarema, estado do Rio de Janeiro.',
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
-- Site: Paróquia Nossa Senhora da Conceição (Saquarema)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-nossa-senhora-da-conceicao-saquarema-29'),
  'site-paroquia-nossa-senhora-da-conceicao-saquarema-29',
  'Paróquia Nossa Senhora da Conceição (Saquarema)',
  'shrine',
  'Praça Oscar de Macedo Soares - Centro',
  'Saquarema',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-42.5112, -22.9351), 4326)::geography,
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

-- Jurisdiction: Paróquia Nossa Senhora de Fátima (Araruama)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-nossa-senhora-de-fatima-araruama-30',
  'Paróquia Nossa Senhora de Fátima (Araruama)',
  'parish',
  'latin',
  'BR',
  'active',
  1955,
  'Paróquia Paróquia Nossa Senhora de Fátima (Araruama) localizada em Araruama, estado do Rio de Janeiro.',
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
-- Site: Paróquia Nossa Senhora de Fátima (Araruama)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-nossa-senhora-de-fatima-araruama-30'),
  'site-paroquia-nossa-senhora-de-fatima-araruama-30',
  'Paróquia Nossa Senhora de Fátima (Araruama)',
  'parish_church',
  'Praça da Matriz - Centro',
  'Araruama',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-42.3412, -22.8712), 4326)::geography,
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

-- Jurisdiction: Paróquia Nossa Senhora da Assunção (Cabo Frio)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-nossa-senhora-da-assuncao-cabo-frio-31',
  'Paróquia Nossa Senhora da Assunção (Cabo Frio)',
  'parish',
  'latin',
  'BR',
  'active',
  1615,
  'Paróquia Paróquia Nossa Senhora da Assunção (Cabo Frio) localizada em Cabo Frio, estado do Rio de Janeiro.',
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
-- Site: Paróquia Nossa Senhora da Assunção (Cabo Frio)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-nossa-senhora-da-assuncao-cabo-frio-31'),
  'site-paroquia-nossa-senhora-da-assuncao-cabo-frio-31',
  'Paróquia Nossa Senhora da Assunção (Cabo Frio)',
  'parish_church',
  'Praça Porto Rocha - Centro',
  'Cabo Frio',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-42.0185, -22.879), 4326)::geography,
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

-- Jurisdiction: Paróquia Sant'Anna (Búzios)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-sant-anna-buzios-32',
  'Paróquia Sant''Anna (Búzios)',
  'parish',
  'latin',
  'BR',
  'active',
  1740,
  'Paróquia Paróquia Sant''Anna (Búzios) localizada em Armação dos Búzios, estado do Rio de Janeiro.',
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
-- Site: Paróquia Sant'Anna (Búzios)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-sant-anna-buzios-32'),
  'site-paroquia-sant-anna-buzios-32',
  'Paróquia Sant''Anna (Búzios)',
  'parish_church',
  'Praia dos Ossos, s/n',
  'Armação dos Búzios',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-41.8845, -22.7485), 4326)::geography,
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

-- Jurisdiction: Paróquia Sacra Família (Arraial do Cabo)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-sacra-familia-arraial-do-cabo-33',
  'Paróquia Sacra Família (Arraial do Cabo)',
  'parish',
  'latin',
  'BR',
  'active',
  1968,
  'Paróquia Paróquia Sacra Família (Arraial do Cabo) localizada em Arraial do Cabo, estado do Rio de Janeiro.',
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
-- Site: Paróquia Sacra Família (Arraial do Cabo)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-sacra-familia-arraial-do-cabo-33'),
  'site-paroquia-sacra-familia-arraial-do-cabo-33',
  'Paróquia Sacra Família (Arraial do Cabo)',
  'parish_church',
  'Praça da Bandeira - Centro',
  'Arraial do Cabo',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-42.0285, -22.9652), 4326)::geography,
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

-- Jurisdiction: Paróquia Santo Antônio (Duque de Caxias)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-santo-antonio-duque-de-caxias-34',
  'Paróquia Santo Antônio (Duque de Caxias)',
  'parish',
  'latin',
  'BR',
  'active',
  1940,
  'Paróquia Paróquia Santo Antônio (Duque de Caxias) localizada em Duque de Caxias, estado do Rio de Janeiro.',
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
-- Site: Paróquia Santo Antônio (Duque de Caxias)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-santo-antonio-duque-de-caxias-34'),
  'site-paroquia-santo-antonio-duque-de-caxias-34',
  'Paróquia Santo Antônio (Duque de Caxias)',
  'cathedral',
  'Av. Governador Leonel de Moura Brizola - Centro',
  'Duque de Caxias',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-43.3112, -22.7852), 4326)::geography,
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

-- Jurisdiction: Paróquia Nossa Senhora de Fátima (Duque de Caxias)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-nossa-senhora-de-fatima-duque-de-caxias-35',
  'Paróquia Nossa Senhora de Fátima (Duque de Caxias)',
  'parish',
  'latin',
  'BR',
  'active',
  1958,
  'Paróquia Paróquia Nossa Senhora de Fátima (Duque de Caxias) localizada em Duque de Caxias, estado do Rio de Janeiro.',
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
-- Site: Paróquia Nossa Senhora de Fátima (Duque de Caxias)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-nossa-senhora-de-fatima-duque-de-caxias-35'),
  'site-paroquia-nossa-senhora-de-fatima-duque-de-caxias-35',
  'Paróquia Nossa Senhora de Fátima (Duque de Caxias)',
  'parish_church',
  'R. Frei Fidélis - Vila Meriti',
  'Duque de Caxias',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-43.3052, -22.7712), 4326)::geography,
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

-- Jurisdiction: Paróquia Catedral Santo Antônio de Jacutinga
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-catedral-santo-antonio-de-jacutinga-36',
  'Paróquia Catedral Santo Antônio de Jacutinga',
  'parish',
  'latin',
  'BR',
  'active',
  1862,
  'Paróquia Paróquia Catedral Santo Antônio de Jacutinga localizada em Nova Iguaçu, estado do Rio de Janeiro.',
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
-- Site: Paróquia Catedral Santo Antônio de Jacutinga
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-catedral-santo-antonio-de-jacutinga-36'),
  'site-paroquia-catedral-santo-antonio-de-jacutinga-36',
  'Paróquia Catedral Santo Antônio de Jacutinga',
  'cathedral',
  'Av. Marechal Floriano Peixoto - Centro',
  'Nova Iguaçu',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-43.4512, -22.7582), 4326)::geography,
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

-- Jurisdiction: Paróquia Nossa Senhora da Conceição (Belford Roxo)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-nossa-senhora-da-conceicao-belford-roxo-37',
  'Paróquia Nossa Senhora da Conceição (Belford Roxo)',
  'parish',
  'latin',
  'BR',
  'active',
  1965,
  'Paróquia Paróquia Nossa Senhora da Conceição (Belford Roxo) localizada em Belford Roxo, estado do Rio de Janeiro.',
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
-- Site: Paróquia Nossa Senhora da Conceição (Belford Roxo)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-nossa-senhora-da-conceicao-belford-roxo-37'),
  'site-paroquia-nossa-senhora-da-conceicao-belford-roxo-37',
  'Paróquia Nossa Senhora da Conceição (Belford Roxo)',
  'parish_church',
  'Praça Getúlio Vargas - Centro',
  'Belford Roxo',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-43.3982, -22.7642), 4326)::geography,
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

-- Jurisdiction: Paróquia Nossa Senhora da Conceição (Nilópolis)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-nossa-senhora-da-conceicao-nilopolis-38',
  'Paróquia Nossa Senhora da Conceição (Nilópolis)',
  'parish',
  'latin',
  'BR',
  'active',
  1935,
  'Paróquia Paróquia Nossa Senhora da Conceição (Nilópolis) localizada em Nilópolis, estado do Rio de Janeiro.',
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
-- Site: Paróquia Nossa Senhora da Conceição (Nilópolis)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-nossa-senhora-da-conceicao-nilopolis-38'),
  'site-paroquia-nossa-senhora-da-conceicao-nilopolis-38',
  'Paróquia Nossa Senhora da Conceição (Nilópolis)',
  'parish_church',
  'R. Pedro Álvares Cabral - Centro',
  'Nilópolis',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-43.4142, -22.8082), 4326)::geography,
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

-- Jurisdiction: Paróquia Nossa Senhora da Conceição (Mesquita)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-nossa-senhora-da-conceicao-mesquita-39',
  'Paróquia Nossa Senhora da Conceição (Mesquita)',
  'parish',
  'latin',
  'BR',
  'active',
  1945,
  'Paróquia Paróquia Nossa Senhora da Conceição (Mesquita) localizada em Mesquita, estado do Rio de Janeiro.',
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
-- Site: Paróquia Nossa Senhora da Conceição (Mesquita)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-nossa-senhora-da-conceicao-mesquita-39'),
  'site-paroquia-nossa-senhora-da-conceicao-mesquita-39',
  'Paróquia Nossa Senhora da Conceição (Mesquita)',
  'parish_church',
  'R. Mr. Watkins - Centro',
  'Mesquita',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-43.4321, -22.7821), 4326)::geography,
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

-- Jurisdiction: Paróquia São João Batista (São João de Meriti)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-sao-joao-batista-sao-joao-de-meriti-40',
  'Paróquia São João Batista (São João de Meriti)',
  'parish',
  'latin',
  'BR',
  'active',
  1890,
  'Paróquia Paróquia São João Batista (São João de Meriti) localizada em São João de Meriti, estado do Rio de Janeiro.',
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
-- Site: Paróquia São João Batista (São João de Meriti)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-sao-joao-batista-sao-joao-de-meriti-40'),
  'site-paroquia-sao-joao-batista-sao-joao-de-meriti-40',
  'Paróquia São João Batista (São João de Meriti)',
  'parish_church',
  'Praça Getúlio Vargas - Centro',
  'São João de Meriti',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-43.3721, -22.8021), 4326)::geography,
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

-- Jurisdiction: Paróquia Nossa Senhora da Conceição (Magé)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-nossa-senhora-da-conceicao-mage-41',
  'Paróquia Nossa Senhora da Conceição (Magé)',
  'parish',
  'latin',
  'BR',
  'active',
  1565,
  'Paróquia Paróquia Nossa Senhora da Conceição (Magé) localizada em Magé, estado do Rio de Janeiro.',
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
-- Site: Paróquia Nossa Senhora da Conceição (Magé)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-nossa-senhora-da-conceicao-mage-41'),
  'site-paroquia-nossa-senhora-da-conceicao-mage-41',
  'Paróquia Nossa Senhora da Conceição (Magé)',
  'parish_church',
  'Praça Doutor Nilo Peçanha - Centro',
  'Magé',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-43.0412, -22.6521), 4326)::geography,
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

-- Jurisdiction: Paróquia Nossa Senhora da Piedade (Suruí)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-nossa-senhora-da-piedade-surui-42',
  'Paróquia Nossa Senhora da Piedade (Suruí)',
  'parish',
  'latin',
  'BR',
  'active',
  1690,
  'Paróquia Paróquia Nossa Senhora da Piedade (Suruí) localizada em Magé, estado do Rio de Janeiro.',
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
-- Site: Paróquia Nossa Senhora da Piedade (Suruí)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-nossa-senhora-da-piedade-surui-42'),
  'site-paroquia-nossa-senhora-da-piedade-surui-42',
  'Paróquia Nossa Senhora da Piedade (Suruí)',
  'shrine',
  'Estrada de Suruí - Magé',
  'Magé',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-43.1021, -22.6852), 4326)::geography,
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

-- Jurisdiction: Catedral de São Pedro de Alcântara
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-catedral-de-sao-pedro-de-alcantara-43',
  'Catedral de São Pedro de Alcântara',
  'parish',
  'latin',
  'BR',
  'active',
  1884,
  'Paróquia Catedral de São Pedro de Alcântara localizada em Petrópolis, estado do Rio de Janeiro.',
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
-- Site: Catedral de São Pedro de Alcântara
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-catedral-de-sao-pedro-de-alcantara-43'),
  'site-catedral-de-sao-pedro-de-alcantara-43',
  'Catedral de São Pedro de Alcântara',
  'cathedral',
  'R. São Pedro de Alcântara, 60 - Centro',
  'Petrópolis',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-43.1786, -22.5086), 4326)::geography,
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

-- Jurisdiction: Paróquia Sagrado Coração de Jesus
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-sagrado-coracao-de-jesus-44',
  'Paróquia Sagrado Coração de Jesus',
  'parish',
  'latin',
  'BR',
  'active',
  1910,
  'Paróquia Paróquia Sagrado Coração de Jesus localizada em Petrópolis, estado do Rio de Janeiro.',
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
-- Site: Paróquia Sagrado Coração de Jesus
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-sagrado-coracao-de-jesus-44'),
  'site-paroquia-sagrado-coracao-de-jesus-44',
  'Paróquia Sagrado Coração de Jesus',
  'parish_church',
  'R. Monte dos Cascatinha - Petrópolis',
  'Petrópolis',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-43.1852, -22.5152), 4326)::geography,
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

-- Jurisdiction: Paróquia Santa Teresa (Teresópolis)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-santa-teresa-teresopolis-45',
  'Paróquia Santa Teresa (Teresópolis)',
  'parish',
  'latin',
  'BR',
  'active',
  1855,
  'Paróquia Paróquia Santa Teresa (Teresópolis) localizada em Teresópolis, estado do Rio de Janeiro.',
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
-- Site: Paróquia Santa Teresa (Teresópolis)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-santa-teresa-teresopolis-45'),
  'site-paroquia-santa-teresa-teresopolis-45',
  'Paróquia Santa Teresa (Teresópolis)',
  'parish_church',
  'Praça Baltazar da Silveira - Várzea',
  'Teresópolis',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-42.9662, -22.4121), 4326)::geography,
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

-- Jurisdiction: Paróquia Santo Antônio (Teresópolis)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-santo-antonio-teresopolis-46',
  'Paróquia Santo Antônio (Teresópolis)',
  'parish',
  'latin',
  'BR',
  'active',
  1930,
  'Paróquia Paróquia Santo Antônio (Teresópolis) localizada em Teresópolis, estado do Rio de Janeiro.',
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
-- Site: Paróquia Santo Antônio (Teresópolis)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-santo-antonio-teresopolis-46'),
  'site-paroquia-santo-antonio-teresopolis-46',
  'Paróquia Santo Antônio (Teresópolis)',
  'parish_church',
  'Av. Oliveira Botelho - Alto',
  'Teresópolis',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-42.9812, -22.4285), 4326)::geography,
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

-- Jurisdiction: Catedral São João Batista (Nova Friburgo)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-catedral-sao-joao-batista-nova-friburgo-47',
  'Catedral São João Batista (Nova Friburgo)',
  'parish',
  'latin',
  'BR',
  'active',
  1820,
  'Paróquia Catedral São João Batista (Nova Friburgo) localizada em Nova Friburgo, estado do Rio de Janeiro.',
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
-- Site: Catedral São João Batista (Nova Friburgo)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-catedral-sao-joao-batista-nova-friburgo-47'),
  'site-catedral-sao-joao-batista-nova-friburgo-47',
  'Catedral São João Batista (Nova Friburgo)',
  'cathedral',
  'Praça Dermeval Barbosa Moreira - Centro',
  'Nova Friburgo',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-42.5312, -22.2818), 4326)::geography,
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

-- Jurisdiction: Paróquia Zé dos Campos (Macaé)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-ze-dos-campos-macae-48',
  'Paróquia Zé dos Campos (Macaé)',
  'parish',
  'latin',
  'BR',
  'active',
  1813,
  'Paróquia Paróquia Zé dos Campos (Macaé) localizada em Macaé, estado do Rio de Janeiro.',
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
-- Site: Paróquia Zé dos Campos (Macaé)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-ze-dos-campos-macae-48'),
  'site-paroquia-ze-dos-campos-macae-48',
  'Paróquia Zé dos Campos (Macaé)',
  'parish_church',
  'Praça Veríssimo de Melo - Centro',
  'Macaé',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-41.7821, -22.3768), 4326)::geography,
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

-- Jurisdiction: Paróquia Nossa Senhora da Conceição (Rio das Ostras)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-nossa-senhora-da-conceicao-rio-das-ostras-49',
  'Paróquia Nossa Senhora da Conceição (Rio das Ostras)',
  'parish',
  'latin',
  'BR',
  'active',
  1960,
  'Paróquia Paróquia Nossa Senhora da Conceição (Rio das Ostras) localizada em Rio das Ostras, estado do Rio de Janeiro.',
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
-- Site: Paróquia Nossa Senhora da Conceição (Rio das Ostras)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-nossa-senhora-da-conceicao-rio-das-ostras-49'),
  'site-paroquia-nossa-senhora-da-conceicao-rio-das-ostras-49',
  'Paróquia Nossa Senhora da Conceição (Rio das Ostras)',
  'parish_church',
  'Praça José Pereira Câmara - Centro',
  'Rio das Ostras',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-41.9482, -22.5251), 4326)::geography,
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

-- Jurisdiction: Catedral Santíssimo Salvador (Campos)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-catedral-santissimo-salvador-campos-50',
  'Catedral Santíssimo Salvador (Campos)',
  'parish',
  'latin',
  'BR',
  'active',
  1652,
  'Paróquia Catedral Santíssimo Salvador (Campos) localizada em Campos dos Goytacazes, estado do Rio de Janeiro.',
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
-- Site: Catedral Santíssimo Salvador (Campos)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-catedral-santissimo-salvador-campos-50'),
  'site-catedral-santissimo-salvador-campos-50',
  'Catedral Santíssimo Salvador (Campos)',
  'cathedral',
  'Praça São Salvador - Centro',
  'Campos dos Goytacazes',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-41.3241, -21.7542), 4326)::geography,
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

-- Jurisdiction: Paróquia Nossa Senhora do Terço (Campos)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-nossa-senhora-do-terco-campos-51',
  'Paróquia Nossa Senhora do Terço (Campos)',
  'parish',
  'latin',
  'BR',
  'active',
  1910,
  'Paróquia Paróquia Nossa Senhora do Terço (Campos) localizada em Campos dos Goytacazes, estado do Rio de Janeiro.',
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
-- Site: Paróquia Nossa Senhora do Terço (Campos)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-nossa-senhora-do-terco-campos-51'),
  'site-paroquia-nossa-senhora-do-terco-campos-51',
  'Paróquia Nossa Senhora do Terço (Campos)',
  'parish_church',
  'R. Barão de Miracema - Centro',
  'Campos dos Goytacazes',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-41.3321, -21.7612), 4326)::geography,
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

-- Jurisdiction: Paróquia São João Batista (São João da Barra)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-sao-joao-batista-sao-joao-da-barra-52',
  'Paróquia São João Batista (São João da Barra)',
  'parish',
  'latin',
  'BR',
  'active',
  1644,
  'Paróquia Paróquia São João Batista (São João da Barra) localizada em São João da Barra, estado do Rio de Janeiro.',
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
-- Site: Paróquia São João Batista (São João da Barra)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-sao-joao-batista-sao-joao-da-barra-52'),
  'site-paroquia-sao-joao-batista-sao-joao-da-barra-52',
  'Paróquia São João Batista (São João da Barra)',
  'parish_church',
  'Praça São João Batista - Centro',
  'São João da Barra',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-41.0512, -21.6401), 4326)::geography,
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

-- Jurisdiction: Paróquia São Fidélis (São Fidélis)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-sao-fidelis-sao-fidelis-53',
  'Paróquia São Fidélis (São Fidélis)',
  'parish',
  'latin',
  'BR',
  'active',
  1785,
  'Paróquia Paróquia São Fidélis (São Fidélis) localizada em São Fidélis, estado do Rio de Janeiro.',
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
-- Site: Paróquia São Fidélis (São Fidélis)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-sao-fidelis-sao-fidelis-53'),
  'site-paroquia-sao-fidelis-sao-fidelis-53',
  'Paróquia São Fidélis (São Fidélis)',
  'shrine',
  'Praça Guilherme Tito de Azevedo - Centro',
  'São Fidélis',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-41.7482, -21.6452), 4326)::geography,
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

-- Jurisdiction: Paróquia São José (Itaperuna)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-sao-jose-itaperuna-54',
  'Paróquia São José (Itaperuna)',
  'parish',
  'latin',
  'BR',
  'active',
  1889,
  'Paróquia Paróquia São José (Itaperuna) localizada em Itaperuna, estado do Rio de Janeiro.',
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
-- Site: Paróquia São José (Itaperuna)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-sao-jose-itaperuna-54'),
  'site-paroquia-sao-jose-itaperuna-54',
  'Paróquia São José (Itaperuna)',
  'parish_church',
  'Praça Getúlio Vargas - Centro',
  'Itaperuna',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-41.8912, -21.2052), 4326)::geography,
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

-- Jurisdiction: Co-Catedral Nossa Senhora da Conceição
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-co-catedral-nossa-senhora-da-conceicao-55',
  'Co-Catedral Nossa Senhora da Conceição',
  'parish',
  'latin',
  'BR',
  'active',
  1954,
  'Paróquia Co-Catedral Nossa Senhora da Conceição localizada em Volta Redonda, estado do Rio de Janeiro.',
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
-- Site: Co-Catedral Nossa Senhora da Conceição
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-co-catedral-nossa-senhora-da-conceicao-55'),
  'site-co-catedral-nossa-senhora-da-conceicao-55',
  'Co-Catedral Nossa Senhora da Conceição',
  'cathedral',
  'R. 14, nº 322 - Vila Santa Cecília',
  'Volta Redonda',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-44.1021, -22.5185), 4326)::geography,
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

-- Jurisdiction: Paróquia Santa Cruz (Volta Redonda)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-santa-cruz-volta-redonda-56',
  'Paróquia Santa Cruz (Volta Redonda)',
  'parish',
  'latin',
  'BR',
  'active',
  1970,
  'Paróquia Paróquia Santa Cruz (Volta Redonda) localizada em Volta Redonda, estado do Rio de Janeiro.',
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
-- Site: Paróquia Santa Cruz (Volta Redonda)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-santa-cruz-volta-redonda-56'),
  'site-paroquia-santa-cruz-volta-redonda-56',
  'Paróquia Santa Cruz (Volta Redonda)',
  'parish_church',
  'Av. Integração - Aterrado',
  'Volta Redonda',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-44.0952, -22.5285), 4326)::geography,
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

-- Jurisdiction: Paróquia São Sebastião (Barra Mansa)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-sao-sebastiao-barra-mansa-57',
  'Paróquia São Sebastião (Barra Mansa)',
  'parish',
  'latin',
  'BR',
  'active',
  1832,
  'Paróquia Paróquia São Sebastião (Barra Mansa) localizada em Barra Mansa, estado do Rio de Janeiro.',
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
-- Site: Paróquia São Sebastião (Barra Mansa)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-sao-sebastiao-barra-mansa-57'),
  'site-paroquia-sao-sebastiao-barra-mansa-57',
  'Paróquia São Sebastião (Barra Mansa)',
  'parish_church',
  'Praça Ponce de León - Centro',
  'Barra Mansa',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-44.1752, -22.5452), 4326)::geography,
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

-- Jurisdiction: Catedral de Santana (Barra do Piraí)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-catedral-de-santana-barra-do-pirai-58',
  'Catedral de Santana (Barra do Piraí)',
  'parish',
  'latin',
  'BR',
  'active',
  1881,
  'Paróquia Catedral de Santana (Barra do Piraí) localizada em Barra do Piraí, estado do Rio de Janeiro.',
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
-- Site: Catedral de Santana (Barra do Piraí)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-catedral-de-santana-barra-do-pirai-58'),
  'site-catedral-de-santana-barra-do-pirai-58',
  'Catedral de Santana (Barra do Piraí)',
  'cathedral',
  'Praça Nilo Peçanha - Centro',
  'Barra do Piraí',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-43.8251, -22.4718), 4326)::geography,
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

-- Jurisdiction: Paróquia Nossa Senhora da Conceição (Resende)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-nossa-senhora-da-conceicao-resende-59',
  'Paróquia Nossa Senhora da Conceição (Resende)',
  'parish',
  'latin',
  'BR',
  'active',
  1744,
  'Paróquia Paróquia Nossa Senhora da Conceição (Resende) localizada em Resende, estado do Rio de Janeiro.',
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
-- Site: Paróquia Nossa Senhora da Conceição (Resende)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-nossa-senhora-da-conceicao-resende-59'),
  'site-paroquia-nossa-senhora-da-conceicao-resende-59',
  'Paróquia Nossa Senhora da Conceição (Resende)',
  'parish_church',
  'Praça Oliveira Botelho - Centro',
  'Resende',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-44.4485, -22.4682), 4326)::geography,
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

-- Jurisdiction: Paróquia Nossa Senhora da Conceição (Angra)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-nossa-senhora-da-conceicao-angra-60',
  'Paróquia Nossa Senhora da Conceição (Angra)',
  'parish',
  'latin',
  'BR',
  'active',
  1593,
  'Paróquia Paróquia Nossa Senhora da Conceição (Angra) localizada em Angra dos Reis, estado do Rio de Janeiro.',
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
-- Site: Paróquia Nossa Senhora da Conceição (Angra)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-nossa-senhora-da-conceicao-angra-60'),
  'site-paroquia-nossa-senhora-da-conceicao-angra-60',
  'Paróquia Nossa Senhora da Conceição (Angra)',
  'parish_church',
  'Praça Silvestre Travassos - Centro',
  'Angra dos Reis',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-44.3182, -23.0065), 4326)::geography,
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

-- Jurisdiction: Paróquia Nossa Senhora dos Remédios (Paraty)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-nossa-senhora-dos-remedios-paraty-61',
  'Paróquia Nossa Senhora dos Remédios (Paraty)',
  'parish',
  'latin',
  'BR',
  'active',
  1646,
  'Paróquia Paróquia Nossa Senhora dos Remédios (Paraty) localizada em Paraty, estado do Rio de Janeiro.',
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
-- Site: Paróquia Nossa Senhora dos Remédios (Paraty)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-nossa-senhora-dos-remedios-paraty-61'),
  'site-paroquia-nossa-senhora-dos-remedios-paraty-61',
  'Paróquia Nossa Senhora dos Remédios (Paraty)',
  'parish_church',
  'Praça Monsenhor Hélio Pires - Centro Histórico',
  'Paraty',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-44.7121, -23.2185), 4326)::geography,
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

-- Jurisdiction: Catedral Nossa Senhora da Glória (Valença)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-catedral-nossa-senhora-da-gloria-valenca-62',
  'Catedral Nossa Senhora da Glória (Valença)',
  'parish',
  'latin',
  'BR',
  'active',
  1803,
  'Paróquia Catedral Nossa Senhora da Glória (Valença) localizada em Valença, estado do Rio de Janeiro.',
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
-- Site: Catedral Nossa Senhora da Glória (Valença)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-catedral-nossa-senhora-da-gloria-valenca-62'),
  'site-catedral-nossa-senhora-da-gloria-valenca-62',
  'Catedral Nossa Senhora da Glória (Valença)',
  'cathedral',
  'Praça Visconde de Rio Preto - Centro',
  'Valença',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-43.7012, -22.2458), 4326)::geography,
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

-- Jurisdiction: Paróquia Nossa Senhora da Conceição (Vassouras)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-nossa-senhora-da-conceicao-vassouras-63',
  'Paróquia Nossa Senhora da Conceição (Vassouras)',
  'parish',
  'latin',
  'BR',
  'active',
  1828,
  'Paróquia Paróquia Nossa Senhora da Conceição (Vassouras) localizada em Vassouras, estado do Rio de Janeiro.',
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
-- Site: Paróquia Nossa Senhora da Conceição (Vassouras)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-nossa-senhora-da-conceicao-vassouras-63'),
  'site-paroquia-nossa-senhora-da-conceicao-vassouras-63',
  'Paróquia Nossa Senhora da Conceição (Vassouras)',
  'parish_church',
  'Praça Barão de Campo Belo - Centro',
  'Vassouras',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-43.6628, -22.4042), 4326)::geography,
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

-- Jurisdiction: Paróquia Santo Antônio (Volta Redonda)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-santo-antonio-volta-redonda-64',
  'Paróquia Santo Antônio (Volta Redonda)',
  'parish',
  'latin',
  'BR',
  'active',
  1960,
  'Paróquia Paróquia Santo Antônio (Volta Redonda) localizada em Volta Redonda, estado do Rio de Janeiro.',
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
-- Site: Paróquia Santo Antônio (Volta Redonda)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-santo-antonio-volta-redonda-64'),
  'site-paroquia-santo-antonio-volta-redonda-64',
  'Paróquia Santo Antônio (Volta Redonda)',
  'parish_church',
  'Av. Amaral Peixoto - Centro',
  'Volta Redonda',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-44.1112, -22.5121), 4326)::geography,
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

-- Jurisdiction: Paróquia Nossa Senhora das Dores (Casimiro de Abreu)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-nossa-senhora-das-dores-casimiro-de-abreu-65',
  'Paróquia Nossa Senhora das Dores (Casimiro de Abreu)',
  'parish',
  'latin',
  'BR',
  'active',
  1850,
  'Paróquia Paróquia Nossa Senhora das Dores (Casimiro de Abreu) localizada em Casimiro de Abreu, estado do Rio de Janeiro.',
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
-- Site: Paróquia Nossa Senhora das Dores (Casimiro de Abreu)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-nossa-senhora-das-dores-casimiro-de-abreu-65'),
  'site-paroquia-nossa-senhora-das-dores-casimiro-de-abreu-65',
  'Paróquia Nossa Senhora das Dores (Casimiro de Abreu)',
  'parish_church',
  'Praça Lucélia de Souza - Centro',
  'Casimiro de Abreu',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-42.2012, -22.4812), 4326)::geography,
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

-- Jurisdiction: Paróquia São João Batista (Cantagalo)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-sao-joao-batista-cantagalo-66',
  'Paróquia São João Batista (Cantagalo)',
  'parish',
  'latin',
  'BR',
  'active',
  1814,
  'Paróquia Paróquia São João Batista (Cantagalo) localizada em Cantagalo, estado do Rio de Janeiro.',
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
-- Site: Paróquia São João Batista (Cantagalo)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-sao-joao-batista-cantagalo-66'),
  'site-paroquia-sao-joao-batista-cantagalo-66',
  'Paróquia São João Batista (Cantagalo)',
  'parish_church',
  'Praça Miguel de Carvalho - Centro',
  'Cantagalo',
  'Rio de Janeiro',
  'BR',
  st_setsrid(st_makepoint(-42.3682, -21.9812), 4326)::geography,
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
