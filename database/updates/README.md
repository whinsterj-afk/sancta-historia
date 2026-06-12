# Banco de Dados — Sancta Historia

Esta pasta guarda os scripts SQL utilizados para criar, corrigir ou atualizar o banco de dados do projeto Sancta Historia no Supabase.

## Objetivo

Manter um histórico organizado das alterações feitas no banco, incluindo:

- criação de tabelas;
- criação de colunas;
- atualização de santos;
- inserção de lotes de dados;
- correções históricas;
- limpeza de duplicidades;
- ajustes de locais, eventos e papas.

## Como usar

Os scripts desta pasta devem ser executados manualmente no Supabase:

SQL Editor → New query → colar o conteúdo do script → Run

## Atenção

Antes de executar qualquer script:

1. Leia o conteúdo completo.
2. Confirme se ele se aplica ao banco atual.
3. Sempre que possível, use `begin;` e `commit;`.
4. Evite executar scripts duplicados sem revisar.