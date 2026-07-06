-- ============================================================
-- Envelope Database v3
-- File: 012_functions.sql
-- ============================================================

--------------------------------------------------------
-- Create Profile
--------------------------------------------------------

CREATE OR REPLACE FUNCTION create_profile()

RETURNS TRIGGER

LANGUAGE plpgsql

AS $$

BEGIN

    INSERT INTO profiles (

        id,
        username,
        current_floor,
        coins,
        level

    )

    VALUES (

        NEW.id,

        COALESCE(
            NEW.raw_user_meta_data->>'username',
            split_part(NEW.email,'@',1)
        ),

        COALESCE(
            (NEW.raw_user_meta_data->>'current_floor')::INTEGER,
            6
        ),

        100,

        1

    );

    RETURN NEW;

END;

$$;

--------------------------------------------------------
-- Claim Letter
--------------------------------------------------------

CREATE OR REPLACE FUNCTION claim_letter(

    p_letter UUID,
    p_mailman UUID

)

RETURNS VOID

LANGUAGE plpgsql

AS $$

BEGIN

    UPDATE letters

    SET

        current_holder = p_mailman,

        status = 'claimed',

        claimed_at = NOW()

    WHERE id = p_letter;

END;

$$;

--------------------------------------------------------
-- Deliver Letter
--------------------------------------------------------

CREATE OR REPLACE FUNCTION deliver_letter(

    p_letter UUID

)

RETURNS VOID

LANGUAGE plpgsql

AS $$

BEGIN

    UPDATE letters

    SET

        current_holder = NULL,

        status = 'delivered',

        delivered_at = NOW()

    WHERE id = p_letter;

END;

$$;

--------------------------------------------------------
-- Open Letter
--------------------------------------------------------

CREATE OR REPLACE FUNCTION open_letter(

    p_letter UUID

)

RETURNS VOID

LANGUAGE plpgsql

AS $$

BEGIN

    UPDATE letters

    SET

        status = 'opened',

        opened_at = NOW()

    WHERE id = p_letter;

END;

$$;