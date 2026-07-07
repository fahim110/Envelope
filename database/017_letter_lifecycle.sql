-- ===========================================
-- Module 017
-- Envelope Letter Lifecycle
-- ===========================================

-- Letter ownership
ALTER TABLE public.letters
ADD COLUMN IF NOT EXISTS current_holder UUID
REFERENCES public.profiles(id);

-- Current delivery status
ALTER TABLE public.letters
ADD COLUMN IF NOT EXISTS status TEXT
DEFAULT 'draft';

-- Delivery timestamps
ALTER TABLE public.letters
ADD COLUMN IF NOT EXISTS deposited_at TIMESTAMPTZ;

ALTER TABLE public.letters
ADD COLUMN IF NOT EXISTS claimed_at TIMESTAMPTZ;

ALTER TABLE public.letters
ADD COLUMN IF NOT EXISTS delivered_at TIMESTAMPTZ;

-- Allowed statuses
ALTER TABLE public.letters
DROP CONSTRAINT IF EXISTS letters_status_check;

ALTER TABLE public.letters
ADD CONSTRAINT letters_status_check
CHECK
(
    status IN
    (
        'draft',
        'ready_for_deposit',
        'at_post_office',
        'claimed',
        'delivered',
        'cancelled'
    )
);