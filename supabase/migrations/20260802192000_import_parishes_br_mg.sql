-- Sancta Historia
-- Migração de Paróquias gerada automaticamente a partir de supabase/data/parishes/BR/MG.json
-- Operação idempotente via ON CONFLICT (slug) DO UPDATE

begin;

-- Jurisdiction: Catedral Nossa Senhora da Boa Viagem
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-catedral-nossa-senhora-da-boa-viagem-0',
  'Catedral Nossa Senhora da Boa Viagem',
  'parish',
  'latin',
  'BR',
  'active',
  1709,
  'Paróquia Catedral Nossa Senhora da Boa Viagem localizada em Belo Horizonte, estado de Minas Gerais.',
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
-- Site: Catedral Nossa Senhora da Boa Viagem
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-catedral-nossa-senhora-da-boa-viagem-0'),
  'site-catedral-nossa-senhora-da-boa-viagem-0',
  'Catedral Nossa Senhora da Boa Viagem',
  'cathedral',
  'R. Sergipe, 175 - Funcionários',
  'Belo Horizonte',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-43.9351, -19.9272), 4326)::geography,
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

-- Jurisdiction: Santuário Basílica de Nossa Senhora da Piedade
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-santuario-basilica-de-nossa-senhora-da-piedade-1',
  'Santuário Basílica de Nossa Senhora da Piedade',
  'parish',
  'latin',
  'BR',
  'active',
  1767,
  'Paróquia Santuário Basílica de Nossa Senhora da Piedade localizada em Caeté, estado de Minas Gerais.',
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
-- Site: Santuário Basílica de Nossa Senhora da Piedade
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-santuario-basilica-de-nossa-senhora-da-piedade-1'),
  'site-santuario-basilica-de-nossa-senhora-da-piedade-1',
  'Santuário Basílica de Nossa Senhora da Piedade',
  'shrine',
  'Serra da Piedade, s/n',
  'Caeté',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-43.6765, -19.8211), 4326)::geography,
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

-- Jurisdiction: Paróquia São José (Centro BH)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-sao-jose-centro-bh-2',
  'Paróquia São José (Centro BH)',
  'parish',
  'latin',
  'BR',
  'active',
  1900,
  'Paróquia Paróquia São José (Centro BH) localizada em Belo Horizonte, estado de Minas Gerais.',
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
-- Site: Paróquia São José (Centro BH)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-sao-jose-centro-bh-2'),
  'site-paroquia-sao-jose-centro-bh-2',
  'Paróquia São José (Centro BH)',
  'parish_church',
  'R. dos Tudilhes, 520 - Centro',
  'Belo Horizonte',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-43.9372, -19.919), 4326)::geography,
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

-- Jurisdiction: Paróquia Nossa Senhora do Carmo (Savassi)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-nossa-senhora-do-carmo-savassi-3',
  'Paróquia Nossa Senhora do Carmo (Savassi)',
  'parish',
  'latin',
  'BR',
  'active',
  1940,
  'Paróquia Paróquia Nossa Senhora do Carmo (Savassi) localizada em Belo Horizonte, estado de Minas Gerais.',
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
-- Site: Paróquia Nossa Senhora do Carmo (Savassi)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-nossa-senhora-do-carmo-savassi-3'),
  'site-paroquia-nossa-senhora-do-carmo-savassi-3',
  'Paróquia Nossa Senhora do Carmo (Savassi)',
  'parish_church',
  'R. Grão Mogol, 502 - Carmo',
  'Belo Horizonte',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-43.9358, -19.9395), 4326)::geography,
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

-- Jurisdiction: Basílica de Nossa Senhora de Lourdes
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-basilica-de-nossa-senhora-de-lourdes-4',
  'Basílica de Nossa Senhora de Lourdes',
  'parish',
  'latin',
  'BR',
  'active',
  1923,
  'Paróquia Basílica de Nossa Senhora de Lourdes localizada em Belo Horizonte, estado de Minas Gerais.',
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
-- Site: Basílica de Nossa Senhora de Lourdes
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-basilica-de-nossa-senhora-de-lourdes-4'),
  'site-basilica-de-nossa-senhora-de-lourdes-4',
  'Basílica de Nossa Senhora de Lourdes',
  'shrine',
  'R. da Bahia, 1596 - Lourdes',
  'Belo Horizonte',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-43.9412, -19.9288), 4326)::geography,
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

-- Jurisdiction: Santuário de São Judas Tadeu
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-santuario-de-sao-judas-tadeu-5',
  'Santuário de São Judas Tadeu',
  'parish',
  'latin',
  'BR',
  'active',
  1954,
  'Paróquia Santuário de São Judas Tadeu localizada em Belo Horizonte, estado de Minas Gerais.',
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
-- Site: Santuário de São Judas Tadeu
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-santuario-de-sao-judas-tadeu-5'),
  'site-santuario-de-sao-judas-tadeu-5',
  'Santuário de São Judas Tadeu',
  'shrine',
  'R. Restinga, 240 - Graça',
  'Belo Horizonte',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-43.9288, -19.9052), 4326)::geography,
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

-- Jurisdiction: Santuário de Saúde e Paz (Beato Padre Eustáquio)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-santuario-de-saude-e-paz-beato-padre-eustaquio-6',
  'Santuário de Saúde e Paz (Beato Padre Eustáquio)',
  'parish',
  'latin',
  'BR',
  'active',
  1943,
  'Paróquia Santuário de Saúde e Paz (Beato Padre Eustáquio) localizada em Belo Horizonte, estado de Minas Gerais.',
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
-- Site: Santuário de Saúde e Paz (Beato Padre Eustáquio)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-santuario-de-saude-e-paz-beato-padre-eustaquio-6'),
  'site-santuario-de-saude-e-paz-beato-padre-eustaquio-6',
  'Santuário de Saúde e Paz (Beato Padre Eustáquio)',
  'shrine',
  'R. Padre Eustáquio, 2400',
  'Belo Horizonte',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-43.9712, -19.9145), 4326)::geography,
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

-- Jurisdiction: Paróquia São Francisco de Assis (Pampulha)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-sao-francisco-de-assis-pampulha-7',
  'Paróquia São Francisco de Assis (Pampulha)',
  'parish',
  'latin',
  'BR',
  'active',
  1943,
  'Paróquia Paróquia São Francisco de Assis (Pampulha) localizada em Belo Horizonte, estado de Minas Gerais.',
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
-- Site: Paróquia São Francisco de Assis (Pampulha)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-sao-francisco-de-assis-pampulha-7'),
  'site-paroquia-sao-francisco-de-assis-pampulha-7',
  'Paróquia São Francisco de Assis (Pampulha)',
  'shrine',
  'Av. Otacílio Negrão de Lima, 3000 - Pampulha',
  'Belo Horizonte',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-43.9785, -19.8582), 4326)::geography,
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

-- Jurisdiction: Paróquia Nossa Senhora da Consolacão e Correia (Santo Agostinho)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-nossa-senhora-da-consolacao-e-correia-santo-agostinho-8',
  'Paróquia Nossa Senhora da Consolacão e Correia (Santo Agostinho)',
  'parish',
  'latin',
  'BR',
  'active',
  1952,
  'Paróquia Paróquia Nossa Senhora da Consolacão e Correia (Santo Agostinho) localizada em Belo Horizonte, estado de Minas Gerais.',
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
-- Site: Paróquia Nossa Senhora da Consolacão e Correia (Santo Agostinho)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-nossa-senhora-da-consolacao-e-correia-santo-agostinho-8'),
  'site-paroquia-nossa-senhora-da-consolacao-e-correia-santo-agostinho-8',
  'Paróquia Nossa Senhora da Consolacão e Correia (Santo Agostinho)',
  'parish_church',
  'R. Manaus, 120 - Santo Agostinho',
  'Belo Horizonte',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-43.9512, -19.9285), 4326)::geography,
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

-- Jurisdiction: Paróquia Santa Teresinha (Sion)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-santa-teresinha-sion-9',
  'Paróquia Santa Teresinha (Sion)',
  'parish',
  'latin',
  'BR',
  'active',
  1938,
  'Paróquia Paróquia Santa Teresinha (Sion) localizada em Belo Horizonte, estado de Minas Gerais.',
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
-- Site: Paróquia Santa Teresinha (Sion)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-santa-teresinha-sion-9'),
  'site-paroquia-santa-teresinha-sion-9',
  'Paróquia Santa Teresinha (Sion)',
  'parish_church',
  'Praça Santa Teresinha, 45 - Sion',
  'Belo Horizonte',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-43.9285, -19.9512), 4326)::geography,
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

-- Jurisdiction: Paróquia Nossa Senhora das Dores (Floresta)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-nossa-senhora-das-dores-floresta-10',
  'Paróquia Nossa Senhora das Dores (Floresta)',
  'parish',
  'latin',
  'BR',
  'active',
  1925,
  'Paróquia Paróquia Nossa Senhora das Dores (Floresta) localizada em Belo Horizonte, estado de Minas Gerais.',
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
-- Site: Paróquia Nossa Senhora das Dores (Floresta)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-nossa-senhora-das-dores-floresta-10'),
  'site-paroquia-nossa-senhora-das-dores-floresta-10',
  'Paróquia Nossa Senhora das Dores (Floresta)',
  'parish_church',
  'R. Silva Jardim, 100 - Floresta',
  'Belo Horizonte',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-43.9242, -19.9112), 4326)::geography,
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

-- Jurisdiction: Paróquia Santo Antônio (Gutierrez)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-santo-antonio-gutierrez-11',
  'Paróquia Santo Antônio (Gutierrez)',
  'parish',
  'latin',
  'BR',
  'active',
  1960,
  'Paróquia Paróquia Santo Antônio (Gutierrez) localizada em Belo Horizonte, estado de Minas Gerais.',
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
-- Site: Paróquia Santo Antônio (Gutierrez)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-santo-antonio-gutierrez-11'),
  'site-paroquia-santo-antonio-gutierrez-11',
  'Paróquia Santo Antônio (Gutierrez)',
  'parish_church',
  'Av. do Contorno, 6735 - Gutierrez',
  'Belo Horizonte',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-43.9582, -19.9382), 4326)::geography,
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

-- Jurisdiction: Paróquia Nossa Senhora de Gonçalo (Contagem)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-nossa-senhora-de-goncalo-contagem-12',
  'Paróquia Nossa Senhora de Gonçalo (Contagem)',
  'parish',
  'latin',
  'BR',
  'active',
  1725,
  'Paróquia Paróquia Nossa Senhora de Gonçalo (Contagem) localizada em Contagem, estado de Minas Gerais.',
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
-- Site: Paróquia Nossa Senhora de Gonçalo (Contagem)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-nossa-senhora-de-goncalo-contagem-12'),
  'site-paroquia-nossa-senhora-de-goncalo-contagem-12',
  'Paróquia Nossa Senhora de Gonçalo (Contagem)',
  'parish_church',
  'Praça Silviano Brandão - Centro',
  'Contagem',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-44.0535, -19.9328), 4326)::geography,
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

-- Jurisdiction: Paróquia Cristo Luz dos Povos (Contagem)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-cristo-luz-dos-povos-contagem-13',
  'Paróquia Cristo Luz dos Povos (Contagem)',
  'parish',
  'latin',
  'BR',
  'active',
  1980,
  'Paróquia Paróquia Cristo Luz dos Povos (Contagem) localizada em Contagem, estado de Minas Gerais.',
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
-- Site: Paróquia Cristo Luz dos Povos (Contagem)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-cristo-luz-dos-povos-contagem-13'),
  'site-paroquia-cristo-luz-dos-povos-contagem-13',
  'Paróquia Cristo Luz dos Povos (Contagem)',
  'parish_church',
  'R. do Registro - Eldorado',
  'Contagem',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-44.0812, -19.9452), 4326)::geography,
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

-- Jurisdiction: Paróquia Nossa Senhora do Carmo (Betim)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-nossa-senhora-do-carmo-betim-14',
  'Paróquia Nossa Senhora do Carmo (Betim)',
  'parish',
  'latin',
  'BR',
  'active',
  1711,
  'Paróquia Paróquia Nossa Senhora do Carmo (Betim) localizada em Betim, estado de Minas Gerais.',
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
-- Site: Paróquia Nossa Senhora do Carmo (Betim)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-nossa-senhora-do-carmo-betim-14'),
  'site-paroquia-nossa-senhora-do-carmo-betim-14',
  'Paróquia Nossa Senhora do Carmo (Betim)',
  'parish_church',
  'Praça N. Sra. do Carmo - Centro',
  'Betim',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-44.1985, -19.9678), 4326)::geography,
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

-- Jurisdiction: Paróquia Nossa Senhora da Conceição (Sabará)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-nossa-senhora-da-conceicao-sabara-15',
  'Paróquia Nossa Senhora da Conceição (Sabará)',
  'parish',
  'latin',
  'BR',
  'active',
  1701,
  'Paróquia Paróquia Nossa Senhora da Conceição (Sabará) localizada em Sabará, estado de Minas Gerais.',
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
-- Site: Paróquia Nossa Senhora da Conceição (Sabará)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-nossa-senhora-da-conceicao-sabara-15'),
  'site-paroquia-nossa-senhora-da-conceicao-sabara-15',
  'Paróquia Nossa Senhora da Conceição (Sabará)',
  'parish_church',
  'Praça Getúlio Vargas - Centro',
  'Sabará',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-43.8055, -19.8912), 4326)::geography,
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

-- Jurisdiction: Paróquia Ó de Sabará (Nossa Senhora do Ó)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-o-de-sabara-nossa-senhora-do-o-16',
  'Paróquia Ó de Sabará (Nossa Senhora do Ó)',
  'parish',
  'latin',
  'BR',
  'active',
  1717,
  'Paróquia Paróquia Ó de Sabará (Nossa Senhora do Ó) localizada em Sabará, estado de Minas Gerais.',
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
-- Site: Paróquia Ó de Sabará (Nossa Senhora do Ó)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-o-de-sabara-nossa-senhora-do-o-16'),
  'site-paroquia-o-de-sabara-nossa-senhora-do-o-16',
  'Paróquia Ó de Sabará (Nossa Senhora do Ó)',
  'shrine',
  'Largo do Ó - Sabará',
  'Sabará',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-43.8112, -19.8885), 4326)::geography,
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

-- Jurisdiction: Paróquia Santa Luzia (Santa Luzia)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-santa-luzia-santa-luzia-17',
  'Paróquia Santa Luzia (Santa Luzia)',
  'parish',
  'latin',
  'BR',
  'active',
  1744,
  'Paróquia Paróquia Santa Luzia (Santa Luzia) localizada em Santa Luzia, estado de Minas Gerais.',
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
-- Site: Paróquia Santa Luzia (Santa Luzia)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-santa-luzia-santa-luzia-17'),
  'site-paroquia-santa-luzia-santa-luzia-17',
  'Paróquia Santa Luzia (Santa Luzia)',
  'parish_church',
  'R. Direita - Centro Histórico',
  'Santa Luzia',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-43.8512, -19.7682), 4326)::geography,
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

-- Jurisdiction: Paróquia Santo Antônio (Nova Lima)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-santo-antonio-nova-lima-18',
  'Paróquia Santo Antônio (Nova Lima)',
  'parish',
  'latin',
  'BR',
  'active',
  1748,
  'Paróquia Paróquia Santo Antônio (Nova Lima) localizada em Nova Lima, estado de Minas Gerais.',
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
-- Site: Paróquia Santo Antônio (Nova Lima)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-santo-antonio-nova-lima-18'),
  'site-paroquia-santo-antonio-nova-lima-18',
  'Paróquia Santo Antônio (Nova Lima)',
  'parish_church',
  'Praça Bernardino de Lima - Centro',
  'Nova Lima',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-43.8482, -19.9852), 4326)::geography,
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

-- Jurisdiction: Paróquia Nossa Senhora da Conceição (Pedro Leopoldo)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-nossa-senhora-da-conceicao-pedro-leopoldo-19',
  'Paróquia Nossa Senhora da Conceição (Pedro Leopoldo)',
  'parish',
  'latin',
  'BR',
  'active',
  1920,
  'Paróquia Paróquia Nossa Senhora da Conceição (Pedro Leopoldo) localizada em Pedro Leopoldo, estado de Minas Gerais.',
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
-- Site: Paróquia Nossa Senhora da Conceição (Pedro Leopoldo)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-nossa-senhora-da-conceicao-pedro-leopoldo-19'),
  'site-paroquia-nossa-senhora-da-conceicao-pedro-leopoldo-19',
  'Paróquia Nossa Senhora da Conceição (Pedro Leopoldo)',
  'parish_church',
  'Praça Chico Xavier - Centro',
  'Pedro Leopoldo',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-44.0412, -19.6182), 4326)::geography,
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

-- Jurisdiction: Catedral de Santo Antônio (Sete Lagoas)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-catedral-de-santo-antonio-sete-lagoas-20',
  'Catedral de Santo Antônio (Sete Lagoas)',
  'parish',
  'latin',
  'BR',
  'active',
  1841,
  'Paróquia Catedral de Santo Antônio (Sete Lagoas) localizada em Sete Lagoas, estado de Minas Gerais.',
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
-- Site: Catedral de Santo Antônio (Sete Lagoas)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-catedral-de-santo-antonio-sete-lagoas-20'),
  'site-catedral-de-santo-antonio-sete-lagoas-20',
  'Catedral de Santo Antônio (Sete Lagoas)',
  'cathedral',
  'Praça Barão do Rio Branco - Centro',
  'Sete Lagoas',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-44.2452, -19.4612), 4326)::geography,
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

-- Jurisdiction: Catedral Basílica da Sé de Mariana
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-catedral-basilica-da-se-de-mariana-21',
  'Catedral Basílica da Sé de Mariana',
  'parish',
  'latin',
  'BR',
  'active',
  1704,
  'Paróquia Catedral Basílica da Sé de Mariana localizada em Mariana, estado de Minas Gerais.',
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
-- Site: Catedral Basílica da Sé de Mariana
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-catedral-basilica-da-se-de-mariana-21'),
  'site-catedral-basilica-da-se-de-mariana-21',
  'Catedral Basílica da Sé de Mariana',
  'cathedral',
  'Praça Cláudio Manoel - Centro',
  'Mariana',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-43.4162, -20.3782), 4326)::geography,
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

-- Jurisdiction: Basílica de Nossa Senhora do Pilar (Ouro Preto)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-basilica-de-nossa-senhora-do-pilar-ouro-preto-22',
  'Basílica de Nossa Senhora do Pilar (Ouro Preto)',
  'parish',
  'latin',
  'BR',
  'active',
  1696,
  'Paróquia Basílica de Nossa Senhora do Pilar (Ouro Preto) localizada em Ouro Preto, estado de Minas Gerais.',
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
-- Site: Basílica de Nossa Senhora do Pilar (Ouro Preto)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-basilica-de-nossa-senhora-do-pilar-ouro-preto-22'),
  'site-basilica-de-nossa-senhora-do-pilar-ouro-preto-22',
  'Basílica de Nossa Senhora do Pilar (Ouro Preto)',
  'shrine',
  'Praça Mons. João Castilho - Pilar',
  'Ouro Preto',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-43.5085, -20.3855), 4326)::geography,
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

-- Jurisdiction: Igreja de São Francisco de Assis (Ouro Preto)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-igreja-de-sao-francisco-de-assis-ouro-preto-23',
  'Igreja de São Francisco de Assis (Ouro Preto)',
  'parish',
  'latin',
  'BR',
  'active',
  1766,
  'Paróquia Igreja de São Francisco de Assis (Ouro Preto) localizada em Ouro Preto, estado de Minas Gerais.',
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
-- Site: Igreja de São Francisco de Assis (Ouro Preto)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-igreja-de-sao-francisco-de-assis-ouro-preto-23'),
  'site-igreja-de-sao-francisco-de-assis-ouro-preto-23',
  'Igreja de São Francisco de Assis (Ouro Preto)',
  'parish_church',
  'Largo de Coimbra - Centro',
  'Ouro Preto',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-43.5028, -20.3868), 4326)::geography,
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

-- Jurisdiction: Paróquia Nossa Senhora da Conceição de Antônio Dias
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-nossa-senhora-da-conceicao-de-antonio-dias-24',
  'Paróquia Nossa Senhora da Conceição de Antônio Dias',
  'parish',
  'latin',
  'BR',
  'active',
  1699,
  'Paróquia Paróquia Nossa Senhora da Conceição de Antônio Dias localizada em Ouro Preto, estado de Minas Gerais.',
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
-- Site: Paróquia Nossa Senhora da Conceição de Antônio Dias
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-nossa-senhora-da-conceicao-de-antonio-dias-24'),
  'site-paroquia-nossa-senhora-da-conceicao-de-antonio-dias-24',
  'Paróquia Nossa Senhora da Conceição de Antônio Dias',
  'parish_church',
  'Praça Antônio Dias - Ouro Preto',
  'Ouro Preto',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-43.5012, -20.3882), 4326)::geography,
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

-- Jurisdiction: Santuário do Bom Jesus de Matosinhos
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-santuario-do-bom-jesus-de-matosinhos-25',
  'Santuário do Bom Jesus de Matosinhos',
  'parish',
  'latin',
  'BR',
  'active',
  1757,
  'Paróquia Santuário do Bom Jesus de Matosinhos localizada em Congonhas, estado de Minas Gerais.',
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
-- Site: Santuário do Bom Jesus de Matosinhos
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-santuario-do-bom-jesus-de-matosinhos-25'),
  'site-santuario-do-bom-jesus-de-matosinhos-25',
  'Santuário do Bom Jesus de Matosinhos',
  'shrine',
  'Praça Basílica - Centro',
  'Congonhas',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-43.8585, -20.4998), 4326)::geography,
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

-- Jurisdiction: Paróquia Nossa Senhora da Conceição (Conselheiro Lafaiete)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-nossa-senhora-da-conceicao-conselheiro-lafaiete-26',
  'Paróquia Nossa Senhora da Conceição (Conselheiro Lafaiete)',
  'parish',
  'latin',
  'BR',
  'active',
  1709,
  'Paróquia Paróquia Nossa Senhora da Conceição (Conselheiro Lafaiete) localizada em Conselheiro Lafaiete, estado de Minas Gerais.',
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
-- Site: Paróquia Nossa Senhora da Conceição (Conselheiro Lafaiete)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-nossa-senhora-da-conceicao-conselheiro-lafaiete-26'),
  'site-paroquia-nossa-senhora-da-conceicao-conselheiro-lafaiete-26',
  'Paróquia Nossa Senhora da Conceição (Conselheiro Lafaiete)',
  'parish_church',
  'Praça Barão de Queluz - Centro',
  'Conselheiro Lafaiete',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-43.7858, -20.6612), 4326)::geography,
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

-- Jurisdiction: Catedral Basílica de Nossa Senhora do Pilar (São João del-Rei)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-catedral-basilica-de-nossa-senhora-do-pilar-sao-joao-del-rei-27',
  'Catedral Basílica de Nossa Senhora do Pilar (São João del-Rei)',
  'parish',
  'latin',
  'BR',
  'active',
  1721,
  'Paróquia Catedral Basílica de Nossa Senhora do Pilar (São João del-Rei) localizada em São João del-Rei, estado de Minas Gerais.',
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
-- Site: Catedral Basílica de Nossa Senhora do Pilar (São João del-Rei)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-catedral-basilica-de-nossa-senhora-do-pilar-sao-joao-del-rei-27'),
  'site-catedral-basilica-de-nossa-senhora-do-pilar-sao-joao-del-rei-27',
  'Catedral Basílica de Nossa Senhora do Pilar (São João del-Rei)',
  'cathedral',
  'R. Getúlio Vargas - Centro',
  'São João del-Rei',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-44.2612, -21.1352), 4326)::geography,
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

-- Jurisdiction: Igreja de São Francisco de Assis (São João del-Rei)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-igreja-de-sao-francisco-de-assis-sao-joao-del-rei-28',
  'Igreja de São Francisco de Assis (São João del-Rei)',
  'parish',
  'latin',
  'BR',
  'active',
  1774,
  'Paróquia Igreja de São Francisco de Assis (São João del-Rei) localizada em São João del-Rei, estado de Minas Gerais.',
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
-- Site: Igreja de São Francisco de Assis (São João del-Rei)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-igreja-de-sao-francisco-de-assis-sao-joao-del-rei-28'),
  'site-igreja-de-sao-francisco-de-assis-sao-joao-del-rei-28',
  'Igreja de São Francisco de Assis (São João del-Rei)',
  'parish_church',
  'Praça Frei Orlando - Centro',
  'São João del-Rei',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-44.2588, -21.1378), 4326)::geography,
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

-- Jurisdiction: Matriz de Santo Antônio (Tiradentes)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-matriz-de-santo-antonio-tiradentes-29',
  'Matriz de Santo Antônio (Tiradentes)',
  'parish',
  'latin',
  'BR',
  'active',
  1710,
  'Paróquia Matriz de Santo Antônio (Tiradentes) localizada em Tiradentes, estado de Minas Gerais.',
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
-- Site: Matriz de Santo Antônio (Tiradentes)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-matriz-de-santo-antonio-tiradentes-29'),
  'site-matriz-de-santo-antonio-tiradentes-29',
  'Matriz de Santo Antônio (Tiradentes)',
  'shrine',
  'R. da Câmara - Centro',
  'Tiradentes',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-44.1785, -21.1102), 4326)::geography,
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

-- Jurisdiction: Paróquia Nossa Senhora das Mercês (Tiradentes)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-nossa-senhora-das-merces-tiradentes-30',
  'Paróquia Nossa Senhora das Mercês (Tiradentes)',
  'parish',
  'latin',
  'BR',
  'active',
  1759,
  'Paróquia Paróquia Nossa Senhora das Mercês (Tiradentes) localizada em Tiradentes, estado de Minas Gerais.',
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
-- Site: Paróquia Nossa Senhora das Mercês (Tiradentes)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-nossa-senhora-das-merces-tiradentes-30'),
  'site-paroquia-nossa-senhora-das-merces-tiradentes-30',
  'Paróquia Nossa Senhora das Mercês (Tiradentes)',
  'parish_church',
  'Largo das Mercês - Tiradentes',
  'Tiradentes',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-44.1752, -21.1112), 4326)::geography,
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

-- Jurisdiction: Catedral Metropolitana Santo Antônio (Diamantina)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-catedral-metropolitana-santo-antonio-diamantina-31',
  'Catedral Metropolitana Santo Antônio (Diamantina)',
  'parish',
  'latin',
  'BR',
  'active',
  1750,
  'Paróquia Catedral Metropolitana Santo Antônio (Diamantina) localizada em Diamantina, estado de Minas Gerais.',
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
-- Site: Catedral Metropolitana Santo Antônio (Diamantina)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-catedral-metropolitana-santo-antonio-diamantina-31'),
  'site-catedral-metropolitana-santo-antonio-diamantina-31',
  'Catedral Metropolitana Santo Antônio (Diamantina)',
  'cathedral',
  'Praça Dom João - Centro',
  'Diamantina',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-43.6012, -18.2452), 4326)::geography,
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

-- Jurisdiction: Paróquia Nossa Senhora da Conceição (Serro)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-nossa-senhora-da-conceicao-serro-32',
  'Paróquia Nossa Senhora da Conceição (Serro)',
  'parish',
  'latin',
  'BR',
  'active',
  1713,
  'Paróquia Paróquia Nossa Senhora da Conceição (Serro) localizada em Serro, estado de Minas Gerais.',
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
-- Site: Paróquia Nossa Senhora da Conceição (Serro)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-nossa-senhora-da-conceicao-serro-32'),
  'site-paroquia-nossa-senhora-da-conceicao-serro-32',
  'Paróquia Nossa Senhora da Conceição (Serro)',
  'parish_church',
  'Praça João Pinheiro - Centro',
  'Serro',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-43.3782, -18.6052), 4326)::geography,
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

-- Jurisdiction: Catedral Metropolitana Santo Antônio (Juiz de Fora)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-catedral-metropolitana-santo-antonio-juiz-de-fora-33',
  'Catedral Metropolitana Santo Antônio (Juiz de Fora)',
  'parish',
  'latin',
  'BR',
  'active',
  1850,
  'Paróquia Catedral Metropolitana Santo Antônio (Juiz de Fora) localizada em Juiz de Fora, estado de Minas Gerais.',
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
-- Site: Catedral Metropolitana Santo Antônio (Juiz de Fora)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-catedral-metropolitana-santo-antonio-juiz-de-fora-33'),
  'site-catedral-metropolitana-santo-antonio-juiz-de-fora-33',
  'Catedral Metropolitana Santo Antônio (Juiz de Fora)',
  'cathedral',
  'R. Santo Antônio, 1201 - Centro',
  'Juiz de Fora',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-43.3485, -21.7612), 4326)::geography,
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

-- Jurisdiction: Paróquia São Mateus (Juiz de Fora)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-sao-mateus-juiz-de-fora-34',
  'Paróquia São Mateus (Juiz de Fora)',
  'parish',
  'latin',
  'BR',
  'active',
  1928,
  'Paróquia Paróquia São Mateus (Juiz de Fora) localizada em Juiz de Fora, estado de Minas Gerais.',
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
-- Site: Paróquia São Mateus (Juiz de Fora)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-sao-mateus-juiz-de-fora-34'),
  'site-paroquia-sao-mateus-juiz-de-fora-34',
  'Paróquia São Mateus (Juiz de Fora)',
  'parish_church',
  'R. São Mateus, 629 - São Mateus',
  'Juiz de Fora',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-43.3512, -21.7712), 4326)::geography,
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

-- Jurisdiction: Paróquia Nossa Senhora da Glória (Juiz de Fora)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-nossa-senhora-da-gloria-juiz-de-fora-35',
  'Paróquia Nossa Senhora da Glória (Juiz de Fora)',
  'parish',
  'latin',
  'BR',
  'active',
  1924,
  'Paróquia Paróquia Nossa Senhora da Glória (Juiz de Fora) localizada em Juiz de Fora, estado de Minas Gerais.',
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
-- Site: Paróquia Nossa Senhora da Glória (Juiz de Fora)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-nossa-senhora-da-gloria-juiz-de-fora-35'),
  'site-paroquia-nossa-senhora-da-gloria-juiz-de-fora-35',
  'Paróquia Nossa Senhora da Glória (Juiz de Fora)',
  'parish_church',
  'Av. dos Andradas, 855 - Morro da Glória',
  'Juiz de Fora',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-43.3542, -21.7512), 4326)::geography,
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

-- Jurisdiction: Paróquia Santa Rita de Cássia (Viçosa)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-santa-rita-de-cassia-vicosa-36',
  'Paróquia Santa Rita de Cássia (Viçosa)',
  'parish',
  'latin',
  'BR',
  'active',
  1800,
  'Paróquia Paróquia Santa Rita de Cássia (Viçosa) localizada em Viçosa, estado de Minas Gerais.',
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
-- Site: Paróquia Santa Rita de Cássia (Viçosa)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-santa-rita-de-cassia-vicosa-36'),
  'site-paroquia-santa-rita-de-cassia-vicosa-36',
  'Paróquia Santa Rita de Cássia (Viçosa)',
  'parish_church',
  'Praça Silviano Brandão - Centro',
  'Viçosa',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-42.8818, -20.7545), 4326)::geography,
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

-- Jurisdiction: Basílica de São José Operário (Barbacena)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-basilica-de-sao-jose-operario-barbacena-37',
  'Basílica de São José Operário (Barbacena)',
  'parish',
  'latin',
  'BR',
  'active',
  1950,
  'Paróquia Basílica de São José Operário (Barbacena) localizada em Barbacena, estado de Minas Gerais.',
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
-- Site: Basílica de São José Operário (Barbacena)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-basilica-de-sao-jose-operario-barbacena-37'),
  'site-basilica-de-sao-jose-operario-barbacena-37',
  'Basílica de São José Operário (Barbacena)',
  'shrine',
  'Praça Dom Silvério - São José',
  'Barbacena',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-43.7712, -21.2255), 4326)::geography,
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

-- Jurisdiction: Paróquia Nossa Senhora da Piedade (Barbacena)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-nossa-senhora-da-piedade-barbacena-38',
  'Paróquia Nossa Senhora da Piedade (Barbacena)',
  'parish',
  'latin',
  'BR',
  'active',
  1725,
  'Paróquia Paróquia Nossa Senhora da Piedade (Barbacena) localizada em Barbacena, estado de Minas Gerais.',
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
-- Site: Paróquia Nossa Senhora da Piedade (Barbacena)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-nossa-senhora-da-piedade-barbacena-38'),
  'site-paroquia-nossa-senhora-da-piedade-barbacena-38',
  'Paróquia Nossa Senhora da Piedade (Barbacena)',
  'parish_church',
  'Praça dos Andradas - Centro',
  'Barbacena',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-43.7745, -21.2212), 4326)::geography,
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

-- Jurisdiction: Paróquia Januário (Ubá)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-januario-uba-39',
  'Paróquia Januário (Ubá)',
  'parish',
  'latin',
  'BR',
  'active',
  1854,
  'Paróquia Paróquia Januário (Ubá) localizada em Ubá, estado de Minas Gerais.',
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
-- Site: Paróquia Januário (Ubá)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-januario-uba-39'),
  'site-paroquia-januario-uba-39',
  'Paróquia Januário (Ubá)',
  'parish_church',
  'Praça São Januário - Centro',
  'Ubá',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-42.9412, -21.1212), 4326)::geography,
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

-- Jurisdiction: Paróquia São Paulo (Muriaé)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-sao-paulo-muriae-40',
  'Paróquia São Paulo (Muriaé)',
  'parish',
  'latin',
  'BR',
  'active',
  1840,
  'Paróquia Paróquia São Paulo (Muriaé) localizada em Muriaé, estado de Minas Gerais.',
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
-- Site: Paróquia São Paulo (Muriaé)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-sao-paulo-muriae-40'),
  'site-paroquia-sao-paulo-muriae-40',
  'Paróquia São Paulo (Muriaé)',
  'parish_church',
  'Praça Coronel Pacheco de Medeiros - Centro',
  'Muriaé',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-42.3682, -21.1352), 4326)::geography,
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

-- Jurisdiction: Paróquia Sant'Ana (Cataguases)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-sant-ana-cataguases-41',
  'Paróquia Sant''Ana (Cataguases)',
  'parish',
  'latin',
  'BR',
  'active',
  1837,
  'Paróquia Paróquia Sant''Ana (Cataguases) localizada em Cataguases, estado de Minas Gerais.',
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
-- Site: Paróquia Sant'Ana (Cataguases)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-sant-ana-cataguases-41'),
  'site-paroquia-sant-ana-cataguases-41',
  'Paróquia Sant''Ana (Cataguases)',
  'parish_church',
  'Praça Rui Barbosa - Centro',
  'Cataguases',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-42.6952, -21.3882), 4326)::geography,
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

-- Jurisdiction: Catedral de São Sebastião (Leopoldina)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-catedral-de-sao-sebastiao-leopoldina-42',
  'Catedral de São Sebastião (Leopoldina)',
  'parish',
  'latin',
  'BR',
  'active',
  1854,
  'Paróquia Catedral de São Sebastião (Leopoldina) localizada em Leopoldina, estado de Minas Gerais.',
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
-- Site: Catedral de São Sebastião (Leopoldina)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-catedral-de-sao-sebastiao-leopoldina-42'),
  'site-catedral-de-sao-sebastiao-leopoldina-42',
  'Catedral de São Sebastião (Leopoldina)',
  'cathedral',
  'Praça Dom Helder Câmara - Centro',
  'Leopoldina',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-42.6421, -21.5321), 4326)::geography,
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

-- Jurisdiction: Catedral Metropolitana Bom Jesus (Pouso Alegre)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-catedral-metropolitana-bom-jesus-pouso-alegre-43',
  'Catedral Metropolitana Bom Jesus (Pouso Alegre)',
  'parish',
  'latin',
  'BR',
  'active',
  1849,
  'Paróquia Catedral Metropolitana Bom Jesus (Pouso Alegre) localizada em Pouso Alegre, estado de Minas Gerais.',
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
-- Site: Catedral Metropolitana Bom Jesus (Pouso Alegre)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-catedral-metropolitana-bom-jesus-pouso-alegre-43'),
  'site-catedral-metropolitana-bom-jesus-pouso-alegre-43',
  'Catedral Metropolitana Bom Jesus (Pouso Alegre)',
  'cathedral',
  'Praça Senador José Bento - Centro',
  'Pouso Alegre',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-45.9362, -22.2302), 4326)::geography,
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

-- Jurisdiction: Paróquia Nossa Senhora da Saúde (Poços de Caldas)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-nossa-senhora-da-saude-pocos-de-caldas-44',
  'Paróquia Nossa Senhora da Saúde (Poços de Caldas)',
  'parish',
  'latin',
  'BR',
  'active',
  1898,
  'Paróquia Paróquia Nossa Senhora da Saúde (Poços de Caldas) localizada em Poços de Caldas, estado de Minas Gerais.',
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
-- Site: Paróquia Nossa Senhora da Saúde (Poços de Caldas)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-nossa-senhora-da-saude-pocos-de-caldas-44'),
  'site-paroquia-nossa-senhora-da-saude-pocos-de-caldas-44',
  'Paróquia Nossa Senhora da Saúde (Poços de Caldas)',
  'parish_church',
  'Praça Pedro Sanches - Centro',
  'Poços de Caldas',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-46.5682, -21.7885), 4326)::geography,
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

-- Jurisdiction: Catedral de Nossa Senhora do Carmo (Varginha)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-catedral-de-nossa-senhora-do-carmo-varginha-45',
  'Catedral de Nossa Senhora do Carmo (Varginha)',
  'parish',
  'latin',
  'BR',
  'active',
  1920,
  'Paróquia Catedral de Nossa Senhora do Carmo (Varginha) localizada em Varginha, estado de Minas Gerais.',
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
-- Site: Catedral de Nossa Senhora do Carmo (Varginha)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-catedral-de-nossa-senhora-do-carmo-varginha-45'),
  'site-catedral-de-nossa-senhora-do-carmo-varginha-45',
  'Catedral de Nossa Senhora do Carmo (Varginha)',
  'cathedral',
  'Praça Dom Cabral - Centro',
  'Varginha',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-45.4321, -21.5542), 4326)::geography,
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

-- Jurisdiction: Paróquia Nossa Senhora da Conceição (Itajubá)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-nossa-senhora-da-conceicao-itajuba-46',
  'Paróquia Nossa Senhora da Conceição (Itajubá)',
  'parish',
  'latin',
  'BR',
  'active',
  1822,
  'Paróquia Paróquia Nossa Senhora da Conceição (Itajubá) localizada em Itajubá, estado de Minas Gerais.',
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
-- Site: Paróquia Nossa Senhora da Conceição (Itajubá)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-nossa-senhora-da-conceicao-itajuba-46'),
  'site-paroquia-nossa-senhora-da-conceicao-itajuba-46',
  'Paróquia Nossa Senhora da Conceição (Itajubá)',
  'parish_church',
  'Praça Theodomiro Santiago - Centro',
  'Itajubá',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-45.4582, -22.4252), 4326)::geography,
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

-- Jurisdiction: Paróquia Senhor Bom Jesus dos Passos (Passos)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-senhor-bom-jesus-dos-passos-passos-47',
  'Paróquia Senhor Bom Jesus dos Passos (Passos)',
  'parish',
  'latin',
  'BR',
  'active',
  1835,
  'Paróquia Paróquia Senhor Bom Jesus dos Passos (Passos) localizada em Passos, estado de Minas Gerais.',
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
-- Site: Paróquia Senhor Bom Jesus dos Passos (Passos)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-senhor-bom-jesus-dos-passos-passos-47'),
  'site-paroquia-senhor-bom-jesus-dos-passos-passos-47',
  'Paróquia Senhor Bom Jesus dos Passos (Passos)',
  'parish_church',
  'Praça Mons. Messias Bragança - Centro',
  'Passos',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-46.6095, -20.7185), 4326)::geography,
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

-- Jurisdiction: Paróquia São Lourenço (São Lourenço)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-sao-lourenco-sao-lourenco-48',
  'Paróquia São Lourenço (São Lourenço)',
  'parish',
  'latin',
  'BR',
  'active',
  1935,
  'Paróquia Paróquia São Lourenço (São Lourenço) localizada em São Lourenço, estado de Minas Gerais.',
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
-- Site: Paróquia São Lourenço (São Lourenço)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-sao-lourenco-sao-lourenco-48'),
  'site-paroquia-sao-lourenco-sao-lourenco-48',
  'Paróquia São Lourenço (São Lourenço)',
  'parish_church',
  'Praça Duque de Caxias - Centro',
  'São Lourenço',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-45.0542, -22.1182), 4326)::geography,
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

-- Jurisdiction: Catedral Metropolitana Sagrado Coração de Jesus (Uberaba)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-catedral-metropolitana-sagrado-coracao-de-jesus-uberaba-49',
  'Catedral Metropolitana Sagrado Coração de Jesus (Uberaba)',
  'parish',
  'latin',
  'BR',
  'active',
  1907,
  'Paróquia Catedral Metropolitana Sagrado Coração de Jesus (Uberaba) localizada em Uberaba, estado de Minas Gerais.',
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
-- Site: Catedral Metropolitana Sagrado Coração de Jesus (Uberaba)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-catedral-metropolitana-sagrado-coracao-de-jesus-uberaba-49'),
  'site-catedral-metropolitana-sagrado-coracao-de-jesus-uberaba-49',
  'Catedral Metropolitana Sagrado Coração de Jesus (Uberaba)',
  'cathedral',
  'Praça Dom Eduardo - Centro',
  'Uberaba',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-47.9312, -19.7485), 4326)::geography,
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

-- Jurisdiction: Catedral Santa Teresinha (Uberlândia)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-catedral-santa-teresinha-uberlandia-50',
  'Catedral Santa Teresinha (Uberlândia)',
  'parish',
  'latin',
  'BR',
  'active',
  1941,
  'Paróquia Catedral Santa Teresinha (Uberlândia) localizada em Uberlândia, estado de Minas Gerais.',
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
-- Site: Catedral Santa Teresinha (Uberlândia)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-catedral-santa-teresinha-uberlandia-50'),
  'site-catedral-santa-teresinha-uberlandia-50',
  'Catedral Santa Teresinha (Uberlândia)',
  'cathedral',
  'Praça Tubal Vilela - Centro',
  'Uberlândia',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-48.2772, -18.9185), 4326)::geography,
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

-- Jurisdiction: Paróquia Nossa Senhora das Dores (Uberlândia)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-nossa-senhora-das-dores-uberlandia-51',
  'Paróquia Nossa Senhora das Dores (Uberlândia)',
  'parish',
  'latin',
  'BR',
  'active',
  1955,
  'Paróquia Paróquia Nossa Senhora das Dores (Uberlândia) localizada em Uberlândia, estado de Minas Gerais.',
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
-- Site: Paróquia Nossa Senhora das Dores (Uberlândia)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-nossa-senhora-das-dores-uberlandia-51'),
  'site-paroquia-nossa-senhora-das-dores-uberlandia-51',
  'Paróquia Nossa Senhora das Dores (Uberlândia)',
  'parish_church',
  'Praça Adolfo Fonseca - Fundinho',
  'Uberlândia',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-48.2682, -18.9252), 4326)::geography,
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

-- Jurisdiction: Paróquia São Domingos (Araxá)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-sao-domingos-araxa-52',
  'Paróquia São Domingos (Araxá)',
  'parish',
  'latin',
  'BR',
  'active',
  1791,
  'Paróquia Paróquia São Domingos (Araxá) localizada em Araxá, estado de Minas Gerais.',
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
-- Site: Paróquia São Domingos (Araxá)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-sao-domingos-araxa-52'),
  'site-paroquia-sao-domingos-araxa-52',
  'Paróquia São Domingos (Araxá)',
  'parish_church',
  'Praça São Domingos - Centro',
  'Araxá',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-46.9412, -19.5935), 4326)::geography,
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

-- Jurisdiction: Catedral de Santo Antônio (Patos de Minas)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-catedral-de-santo-antonio-patos-de-minas-53',
  'Catedral de Santo Antônio (Patos de Minas)',
  'parish',
  'latin',
  'BR',
  'active',
  1892,
  'Paróquia Catedral de Santo Antônio (Patos de Minas) localizada em Patos de Minas, estado de Minas Gerais.',
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
-- Site: Catedral de Santo Antônio (Patos de Minas)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-catedral-de-santo-antonio-patos-de-minas-53'),
  'site-catedral-de-santo-antonio-patos-de-minas-53',
  'Catedral de Santo Antônio (Patos de Minas)',
  'cathedral',
  'Praça Desembargador Frederico - Centro',
  'Patos de Minas',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-46.5182, -18.5882), 4326)::geography,
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

-- Jurisdiction: Catedral de São Sebastião (Coronel Fabriciano / Ipatinga)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-catedral-de-sao-sebastiao-coronel-fabriciano-ipatinga-54',
  'Catedral de São Sebastião (Coronel Fabriciano / Ipatinga)',
  'parish',
  'latin',
  'BR',
  'active',
  1948,
  'Paróquia Catedral de São Sebastião (Coronel Fabriciano / Ipatinga) localizada em Coronel Fabriciano, estado de Minas Gerais.',
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
-- Site: Catedral de São Sebastião (Coronel Fabriciano / Ipatinga)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-catedral-de-sao-sebastiao-coronel-fabriciano-ipatinga-54'),
  'site-catedral-de-sao-sebastiao-coronel-fabriciano-ipatinga-54',
  'Catedral de São Sebastião (Coronel Fabriciano / Ipatinga)',
  'cathedral',
  'Praça Louis Ensch - Centro',
  'Coronel Fabriciano',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-42.6282, -19.5182), 4326)::geography,
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

-- Jurisdiction: Catedral de Santo Antônio (Governador Valadares)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-catedral-de-santo-antonio-governador-valadares-55',
  'Catedral de Santo Antônio (Governador Valadares)',
  'parish',
  'latin',
  'BR',
  'active',
  1915,
  'Paróquia Catedral de Santo Antônio (Governador Valadares) localizada em Governador Valadares, estado de Minas Gerais.',
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
-- Site: Catedral de Santo Antônio (Governador Valadares)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-catedral-de-santo-antonio-governador-valadares-55'),
  'site-catedral-de-santo-antonio-governador-valadares-55',
  'Catedral de Santo Antônio (Governador Valadares)',
  'cathedral',
  'Praça Manuel da Silva Neto - Centro',
  'Governador Valadares',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-41.9482, -18.8521), 4326)::geography,
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

-- Jurisdiction: Catedral Nossa Senhora Aparecida (Montes Claros)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-catedral-nossa-senhora-aparecida-montes-claros-56',
  'Catedral Nossa Senhora Aparecida (Montes Claros)',
  'parish',
  'latin',
  'BR',
  'active',
  1950,
  'Paróquia Catedral Nossa Senhora Aparecida (Montes Claros) localizada em Montes Claros, estado de Minas Gerais.',
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
-- Site: Catedral Nossa Senhora Aparecida (Montes Claros)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-catedral-nossa-senhora-aparecida-montes-claros-56'),
  'site-catedral-nossa-senhora-aparecida-montes-claros-56',
  'Catedral Nossa Senhora Aparecida (Montes Claros)',
  'cathedral',
  'Praça Pio XII - Centro',
  'Montes Claros',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-43.8612, -16.7252), 4326)::geography,
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

-- Jurisdiction: Paróquia Nossa Senhora da Conceição (Januária)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-paroquia-nossa-senhora-da-conceicao-januaria-57',
  'Paróquia Nossa Senhora da Conceição (Januária)',
  'parish',
  'latin',
  'BR',
  'active',
  1835,
  'Paróquia Paróquia Nossa Senhora da Conceição (Januária) localizada em Januária, estado de Minas Gerais.',
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
-- Site: Paróquia Nossa Senhora da Conceição (Januária)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-paroquia-nossa-senhora-da-conceicao-januaria-57'),
  'site-paroquia-nossa-senhora-da-conceicao-januaria-57',
  'Paróquia Nossa Senhora da Conceição (Januária)',
  'parish_church',
  'Praça Getúlio Vargas - Centro',
  'Januária',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-44.3682, -15.4852), 4326)::geography,
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

-- Jurisdiction: Catedral de Imaculada Conceição (Teófilo Otoni)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-catedral-de-imaculada-conceicao-teofilo-otoni-58',
  'Catedral de Imaculada Conceição (Teófilo Otoni)',
  'parish',
  'latin',
  'BR',
  'active',
  1858,
  'Paróquia Catedral de Imaculada Conceição (Teófilo Otoni) localizada em Teófilo Otoni, estado de Minas Gerais.',
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
-- Site: Catedral de Imaculada Conceição (Teófilo Otoni)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-catedral-de-imaculada-conceicao-teofilo-otoni-58'),
  'site-catedral-de-imaculada-conceicao-teofilo-otoni-58',
  'Catedral de Imaculada Conceição (Teófilo Otoni)',
  'cathedral',
  'Praça Tiradentes - Centro',
  'Teófilo Otoni',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-41.5052, -17.8582), 4326)::geography,
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

-- Jurisdiction: Basílica de São Geraldo (Curvelo)
insert into public.ecclesiastical_jurisdictions (
  slug, name, canonical_type, tradition, country_code, status, erected_year, description, is_published
) values (
  'paroquia-basilica-de-sao-geraldo-curvelo-59',
  'Basílica de São Geraldo (Curvelo)',
  'parish',
  'latin',
  'BR',
  'active',
  1906,
  'Paróquia Basílica de São Geraldo (Curvelo) localizada em Curvelo, estado de Minas Gerais.',
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
-- Site: Basílica de São Geraldo (Curvelo)
insert into public.ecclesiastical_sites (
  jurisdiction_id, slug, name, site_type, address, locality, admin_area, country_code,
  location, min_zoom, display_rank, is_primary, is_published
) values (
  (select id from public.ecclesiastical_jurisdictions where slug = 'paroquia-basilica-de-sao-geraldo-curvelo-59'),
  'site-basilica-de-sao-geraldo-curvelo-59',
  'Basílica de São Geraldo (Curvelo)',
  'shrine',
  'Praça Basílica - Centro',
  'Curvelo',
  'Minas Gerais',
  'BR',
  st_setsrid(st_makepoint(-44.4312, -18.7562), 4326)::geography,
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

commit;
