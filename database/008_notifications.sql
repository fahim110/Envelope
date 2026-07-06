-- ============================================================
-- Envelope Database v3
-- File: 007_letter_history.sql
-- ============================================================

--------------------------------------------------------
-- Letter History
--------------------------------------------------------

CREATE TABLE IF NOT EXISTS letter_history (

    id UUID PRIMARY KEY
        DEFAULT gen_random_uuid(),

    letter_id UUID NOT NULL
        REFERENCES letters(id)
        ON DELETE CASCADE,

    performed_by UUID
        REFERENCES profiles(id)
        ON DELETE SET NULL,

    action history_action
        NOT NULL,

    notes TEXT,

    created_at TIMESTAMPTZ
        NOT NULL
        DEFAULT NOW()

);

--------------------------------------------------------
-- Indexes
--------------------------------------------------------

CREATE INDEX IF NOT EXISTS idx_history_letter
ON letter_history(letter_id);

CREATE INDEX IF NOT EXISTS idx_history_user
ON letter_history(performed_by);

CREATE INDEX IF NOT EXISTS idx_history_action
ON letter_history(action);

CREATE INDEX IF NOT EXISTS idx_history_time
ON letter_history(created_at);

--------------------------------------------------------
-- Function
--------------------------------------------------------

CREATE OR REPLACE FUNCTION log_letter_history(

    p_letter UUID,
    p_user UUID,
    p_action history_action,
    p_notes TEXT DEFAULT NULL

)

RETURNS VOID

LANGUAGE plpgsql

AS $$

BEGIN

    INSERT INTO letter_history(

        letter_id,
        performed_by,
        action,
        notes

    )

    VALUES(

        p_letter,
        p_user,
        p_action,
        p_notes

    );

END;

$$;