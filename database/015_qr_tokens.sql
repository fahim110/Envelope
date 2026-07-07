-- ===========================================
-- 015_qr_tokens.sql
-- Envelope QR Transfer System
-- ===========================================

create table if not exists public.qr_tokens (

    id uuid primary key default gen_random_uuid(),

    letter_id uuid not null
        references public.letters(id)
        on delete cascade,

    token uuid not null default gen_random_uuid(),

    qr_type text not null,

    generated_by uuid
        references public.profiles(id),

    current_holder uuid
        references public.profiles(id),

    is_used boolean default false,

    expires_at timestamptz,

    created_at timestamptz default now()

);

create index if not exists idx_qr_token
on public.qr_tokens(token);

create index if not exists idx_letter_token
on public.qr_tokens(letter_id);