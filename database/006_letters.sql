-- ============================================================
-- Envelope Database v3
-- File: 006_letters.sql
-- ============================================================

--------------------------------------------------------
-- Letters
--------------------------------------------------------

CREATE TABLE IF NOT EXISTS letters (

    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    ----------------------------------------------------
    -- Ownership
    ----------------------------------------------------

    sender_id UUID NOT NULL
        REFERENCES profiles(id)
        ON DELETE CASCADE,

    recipient_id UUID NOT NULL
        REFERENCES profiles(id)
        ON DELETE CASCADE,

    ----------------------------------------------------
    -- Delivery
    ----------------------------------------------------

    current_holder UUID
        REFERENCES profiles(id)
        ON DELETE SET NULL,

    hub_id UUID
        REFERENCES postal_hubs(id)
        ON DELETE SET NULL,

    ----------------------------------------------------
    -- Appearance
    ----------------------------------------------------

    stamp_id UUID
        REFERENCES stamps(id)
        ON DELETE SET NULL,

    ----------------------------------------------------
    -- Letter Content
    ----------------------------------------------------

    title VARCHAR(150),

    body TEXT NOT NULL,

    ----------------------------------------------------
    -- Status
    ----------------------------------------------------

    status letter_status
        NOT NULL
        DEFAULT 'draft',

    type letter_type
        NOT NULL
        DEFAULT 'normal',

    priority priority_level
        NOT NULL
        DEFAULT 'normal',

    ----------------------------------------------------
    -- Options
    ----------------------------------------------------

    is_anonymous BOOLEAN
        NOT NULL
        DEFAULT FALSE,

    is_sealed BOOLEAN
        NOT NULL
        DEFAULT TRUE,

    ----------------------------------------------------
    -- Future Features
    ----------------------------------------------------

    has_attachment BOOLEAN
        NOT NULL
        DEFAULT FALSE,

    ----------------------------------------------------
    -- Important Dates
    ----------------------------------------------------

    created_at TIMESTAMPTZ
        NOT NULL
        DEFAULT NOW(),

    updated_at TIMESTAMPTZ
        NOT NULL
        DEFAULT NOW(),

    dropped_at TIMESTAMPTZ,

    claimed_at TIMESTAMPTZ,

    delivered_at TIMESTAMPTZ,

    opened_at TIMESTAMPTZ

);

--------------------------------------------------------
-- Indexes
--------------------------------------------------------

CREATE INDEX IF NOT EXISTS idx_letter_sender
ON letters(sender_id);

CREATE INDEX IF NOT EXISTS idx_letter_recipient
ON letters(recipient_id);

CREATE INDEX IF NOT EXISTS idx_letter_holder
ON letters(current_holder);

CREATE INDEX IF NOT EXISTS idx_letter_status
ON letters(status);

CREATE INDEX IF NOT EXISTS idx_letter_hub
ON letters(hub_id);

CREATE INDEX IF NOT EXISTS idx_letter_created
ON letters(created_at);

--------------------------------------------------------
-- Automatically Update updated_at
--------------------------------------------------------

DROP TRIGGER IF EXISTS update_letters_updated_at
ON letters;

CREATE TRIGGER update_letters_updated_at

BEFORE UPDATE

ON letters

FOR EACH ROW

EXECUTE FUNCTION update_updated_at_column();