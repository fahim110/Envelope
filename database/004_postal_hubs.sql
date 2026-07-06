-- ============================================================
-- Envelope Database v3
-- File: 004_postal_hubs.sql
-- ============================================================

CREATE TABLE IF NOT EXISTS postal_hubs (

    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    name VARCHAR(100) NOT NULL UNIQUE,

    building VARCHAR(100) NOT NULL,

    floor INTEGER NOT NULL
        CHECK(floor BETWEEN 1 AND 12),

    description TEXT,

    qr_token UUID NOT NULL
        DEFAULT gen_random_uuid(),

    is_active BOOLEAN NOT NULL
        DEFAULT TRUE,

    created_at TIMESTAMPTZ NOT NULL
        DEFAULT NOW()

);

--------------------------------------------------------
-- Indexes
--------------------------------------------------------

CREATE INDEX IF NOT EXISTS idx_hub_name
ON postal_hubs(name);

CREATE INDEX IF NOT EXISTS idx_hub_qr
ON postal_hubs(qr_token);

--------------------------------------------------------
-- Seed the Central Post Office
--------------------------------------------------------

INSERT INTO postal_hubs (

    name,
    building,
    floor,
    description

)

SELECT

    'Central Post Office',
    'BRAC University',
    6,
    'Main collection hub for Envelope.'

WHERE NOT EXISTS (

    SELECT 1
    FROM postal_hubs
    WHERE name = 'Central Post Office'

);