-- ============================================================
-- Envelope Database v3
-- File: 010_reports.sql
-- ============================================================

CREATE TABLE IF NOT EXISTS reports (

    id UUID PRIMARY KEY
        DEFAULT gen_random_uuid(),

    reporter_id UUID NOT NULL
        REFERENCES profiles(id)
        ON DELETE CASCADE,

    letter_id UUID
        REFERENCES letters(id)
        ON DELETE CASCADE,

    reported_user UUID
        REFERENCES profiles(id)
        ON DELETE CASCADE,

    reason TEXT NOT NULL,

    status report_status
        NOT NULL DEFAULT 'pending',

    reviewed_by UUID
        REFERENCES profiles(id)
        ON DELETE SET NULL,

    reviewed_at TIMESTAMPTZ,

    created_at TIMESTAMPTZ
        NOT NULL DEFAULT NOW()

);

--------------------------------------------------------
-- Indexes
--------------------------------------------------------

CREATE INDEX IF NOT EXISTS idx_reports_status
ON reports(status);

CREATE INDEX IF NOT EXISTS idx_reports_reporter
ON reports(reporter_id);

CREATE INDEX IF NOT EXISTS idx_reports_letter
ON reports(letter_id);