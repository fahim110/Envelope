-- ============================================================
-- Envelope Database v3
-- File: 001_extensions_and_enums.sql
--
-- Purpose:
-- Creates PostgreSQL extensions and ENUM types.
-- This file should always be run first.
-- ============================================================

---------------------------------------------------------------
-- Extensions
---------------------------------------------------------------

CREATE EXTENSION IF NOT EXISTS "pgcrypto";

---------------------------------------------------------------
-- User Roles
---------------------------------------------------------------

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_type WHERE typname = 'user_role'
    ) THEN

        CREATE TYPE user_role AS ENUM (

            'student',
            'admin'

        );

    END IF;
END $$;

---------------------------------------------------------------
-- Letter Status
---------------------------------------------------------------

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_type WHERE typname = 'letter_status'
    ) THEN

        CREATE TYPE letter_status AS ENUM (

            'draft',

            'at_hub',

            'claimed',

            'delivered',

            'opened',

            'dead_letter',

            'ghost_letter'

        );

    END IF;
END $$;

---------------------------------------------------------------
-- Letter Type
---------------------------------------------------------------

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_type WHERE typname = 'letter_type'
    ) THEN

        CREATE TYPE letter_type AS ENUM (

            'normal',

            'anonymous',

            'official',

            'event'

        );

    END IF;
END $$;

---------------------------------------------------------------
-- Priority
---------------------------------------------------------------

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_type WHERE typname = 'priority_level'
    ) THEN

        CREATE TYPE priority_level AS ENUM (

            'low',

            'normal',

            'high',

            'urgent'

        );

    END IF;
END $$;

---------------------------------------------------------------
-- Stamp Rarity
---------------------------------------------------------------

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_type WHERE typname = 'rarity_level'
    ) THEN

        CREATE TYPE rarity_level AS ENUM (

            'common',

            'uncommon',

            'rare',

            'epic',

            'legendary'

        );

    END IF;
END $$;

---------------------------------------------------------------
-- History Actions
---------------------------------------------------------------

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_type WHERE typname = 'history_action'
    ) THEN

        CREATE TYPE history_action AS ENUM (

            'created',

            'draft_saved',

            'dropped_at_hub',

            'claimed',

            'delivered',

            'opened',

            'returned',

            'expired_to_dead',

            'moved_to_ghost',

            'deleted'

        );

    END IF;
END $$;

---------------------------------------------------------------
-- Notification Types
---------------------------------------------------------------

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_type WHERE typname = 'notification_type'
    ) THEN

        CREATE TYPE notification_type AS ENUM (

            'letter_claimed',

            'letter_delivered',

            'letter_opened',

            'dead_letter',

            'ghost_letter',

            'system',

            'report_update'

        );

    END IF;
END $$;

---------------------------------------------------------------
-- Report Status
---------------------------------------------------------------

DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_type WHERE typname = 'report_status'
    ) THEN

        CREATE TYPE report_status AS ENUM (

            'pending',

            'in_review',

            'resolved',

            'rejected'

        );

    END IF;
END $$;

---------------------------------------------------------------
-- End of File
---------------------------------------------------------------