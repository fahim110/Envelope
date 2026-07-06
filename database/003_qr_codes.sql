-- ============================================================
-- Envelope Database v3
-- File: 003_qr_codes.sql
-- ============================================================

CREATE TABLE IF NOT EXISTS qr_codes (

    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    user_id UUID NOT NULL
        REFERENCES profiles(id)
        ON DELETE CASCADE,

    qr_token UUID NOT NULL
        DEFAULT gen_random_uuid(),

    is_active BOOLEAN NOT NULL
        DEFAULT TRUE,

    total_scans INTEGER NOT NULL
        DEFAULT 0,

    last_scanned_at TIMESTAMPTZ,

    created_at TIMESTAMPTZ NOT NULL
        DEFAULT NOW(),

    UNIQUE(user_id),

    UNIQUE(qr_token)

);

--------------------------------------------------------
-- Indexes
--------------------------------------------------------

CREATE INDEX IF NOT EXISTS idx_qr_user
ON qr_codes(user_id);

CREATE INDEX IF NOT EXISTS idx_qr_token
ON qr_codes(qr_token);

--------------------------------------------------------
-- Function
--------------------------------------------------------

CREATE OR REPLACE FUNCTION create_user_qr()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN

    INSERT INTO qr_codes(user_id)
    VALUES (NEW.id);

    RETURN NEW;

END;
$$;

--------------------------------------------------------
-- Trigger
--------------------------------------------------------

DROP TRIGGER IF EXISTS create_qr_after_profile
ON profiles;

CREATE TRIGGER create_qr_after_profile

AFTER INSERT

ON profiles

FOR EACH ROW

EXECUTE FUNCTION create_user_qr();