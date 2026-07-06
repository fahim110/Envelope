-- ============================================================
-- Envelope Database v3
-- File: 002_profiles.sql
-- ============================================================

CREATE TABLE IF NOT EXISTS profiles (

    id UUID PRIMARY KEY
        REFERENCES auth.users(id)
        ON DELETE CASCADE,

    username VARCHAR(30) UNIQUE NOT NULL,

    full_name VARCHAR(100),

    department VARCHAR(100),

    current_floor INTEGER NOT NULL
        CHECK(current_floor BETWEEN 1 AND 12),

    avatar_url TEXT,

    role user_role NOT NULL DEFAULT 'student',

    is_volunteer_mailman BOOLEAN NOT NULL DEFAULT FALSE,

    reputation INTEGER NOT NULL DEFAULT 0,

    xp INTEGER NOT NULL DEFAULT 0,

    level INTEGER NOT NULL DEFAULT 1,

    coins INTEGER NOT NULL DEFAULT 0,

    letters_sent INTEGER NOT NULL DEFAULT 0,

    letters_received INTEGER NOT NULL DEFAULT 0,

    letters_delivered INTEGER NOT NULL DEFAULT 0,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()

);

--------------------------------------------------------
-- Indexes
--------------------------------------------------------

CREATE INDEX IF NOT EXISTS idx_profiles_username
ON profiles(username);

CREATE INDEX IF NOT EXISTS idx_profiles_department
ON profiles(department);

CREATE INDEX IF NOT EXISTS idx_profiles_floor
ON profiles(current_floor);

CREATE INDEX IF NOT EXISTS idx_profiles_mailman
ON profiles(is_volunteer_mailman);

--------------------------------------------------------
-- Update Timestamp Function
--------------------------------------------------------

CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN

    NEW.updated_at = NOW();

    RETURN NEW;

END;
$$;

--------------------------------------------------------
-- Trigger
--------------------------------------------------------

DROP TRIGGER IF EXISTS update_profiles_updated_at
ON profiles;

CREATE TRIGGER update_profiles_updated_at

BEFORE UPDATE

ON profiles

FOR EACH ROW

EXECUTE FUNCTION update_updated_at_column();