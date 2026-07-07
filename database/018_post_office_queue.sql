-- ===========================================
-- Module 018
-- Central Post Office Queue
-- ===========================================

CREATE TABLE IF NOT EXISTS public.post_office_queue
(
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    letter_id UUID NOT NULL
    REFERENCES public.letters(id)
    ON DELETE CASCADE,

    deposited_by UUID NOT NULL
    REFERENCES public.profiles(id),

    claimed_by UUID
    REFERENCES public.profiles(id),

    deposited_at TIMESTAMPTZ DEFAULT now(),

    claimed_at TIMESTAMPTZ,

    delivered_at TIMESTAMPTZ,

    is_active BOOLEAN DEFAULT TRUE
);

CREATE INDEX IF NOT EXISTS idx_queue_letter
ON public.post_office_queue(letter_id);

CREATE INDEX IF NOT EXISTS idx_queue_claimed
ON public.post_office_queue(claimed_by);