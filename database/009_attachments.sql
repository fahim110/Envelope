-- ============================================================
-- Envelope Database v3
-- File: 009_attachments.sql
-- ============================================================

CREATE TABLE IF NOT EXISTS attachments (

    id UUID PRIMARY KEY
        DEFAULT gen_random_uuid(),

    letter_id UUID NOT NULL
        REFERENCES letters(id)
        ON DELETE CASCADE,

    uploaded_by UUID NOT NULL
        REFERENCES profiles(id)
        ON DELETE CASCADE,

    file_name VARCHAR(255) NOT NULL,

    storage_path TEXT NOT NULL UNIQUE,

    file_type VARCHAR(50) NOT NULL,

    file_size BIGINT NOT NULL,

    uploaded_at TIMESTAMPTZ
        NOT NULL DEFAULT NOW()

);

--------------------------------------------------------
-- Indexes
--------------------------------------------------------

CREATE INDEX IF NOT EXISTS idx_attachment_letter
ON attachments(letter_id);

CREATE INDEX IF NOT EXISTS idx_attachment_user
ON attachments(uploaded_by);

CREATE INDEX IF NOT EXISTS idx_attachment_type
ON attachments(file_type);