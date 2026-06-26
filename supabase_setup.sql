-- ════════════════════════════════════════════════════════════════
--  KUYAYKI CLOWN — Esquema Supabase para Asistencia y Comentarios
--  Ejecuta este script en: Supabase → SQL Editor → New query → Run
-- ════════════════════════════════════════════════════════════════

-- 1) Tabla de ASISTENCIA (override por participación).
--    Solo se guarda fila cuando alguien cambia el valor.
--    asistio = true  → asistió (valor por defecto en la app)
--    asistio = false → NO asistió (se excluye de estadísticas y tabla)
create table if not exists public.asistencia (
    record_key  text primary key,         -- clave natural: dni||mes||fecha
    dni         text,
    mes         text,
    fecha       text,                      -- "Fechas Asistir" (evento)
    asistio     boolean not null default true,
    updated_at  timestamptz not null default now()
);

-- 2) Tabla de COMENTARIOS (varios por participación).
create table if not exists public.comentarios (
    id          bigint generated always as identity primary key,
    record_key  text not null,             -- mismo dni||mes||fecha
    dni         text,
    comentario  text not null,
    autor       text,                      -- opcional, quién comentó
    created_at  timestamptz not null default now()
);

create index if not exists idx_comentarios_record on public.comentarios (record_key);

-- 3) Row Level Security.
--    Herramienta interna: se permite a la clave anónima leer/escribir.
--    (Si más adelante quieres restringir, aquí se cambian las policies.)
alter table public.asistencia  enable row level security;
alter table public.comentarios enable row level security;

-- ASISTENCIA: lectura, inserción y actualización para anon
drop policy if exists "asistencia_select" on public.asistencia;
drop policy if exists "asistencia_insert" on public.asistencia;
drop policy if exists "asistencia_update" on public.asistencia;
create policy "asistencia_select" on public.asistencia for select to anon using (true);
create policy "asistencia_insert" on public.asistencia for insert to anon with check (true);
create policy "asistencia_update" on public.asistencia for update to anon using (true) with check (true);

-- COMENTARIOS: lectura, inserción y borrado para anon
drop policy if exists "comentarios_select" on public.comentarios;
drop policy if exists "comentarios_insert" on public.comentarios;
drop policy if exists "comentarios_delete" on public.comentarios;
create policy "comentarios_select" on public.comentarios for select to anon using (true);
create policy "comentarios_insert" on public.comentarios for insert to anon with check (true);
create policy "comentarios_delete" on public.comentarios for delete to anon using (true);

-- Listo. Copia luego en la web (config.js):
--   Project URL  → Supabase → Project Settings → Data API → Project URL
--   anon key     → Supabase → Project Settings → API Keys → anon public
