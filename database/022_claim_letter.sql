-- ===========================================
-- Module 022
-- Volunteer Claims Letter
-- ===========================================

CREATE OR REPLACE FUNCTION claim_letter(

    p_queue_id UUID,

    p_mailman UUID

)

RETURNS VOID

LANGUAGE plpgsql

AS
$$

DECLARE

    v_letter UUID;

BEGIN

    -- Lock queue row to prevent two volunteers
    -- claiming the same letter.

    SELECT letter_id

    INTO v_letter

    FROM post_office_queue

    WHERE id = p_queue_id

    FOR UPDATE;

    UPDATE post_office_queue

    SET

        claimed_by = p_mailman,

        claimed_at = NOW()

    WHERE id = p_queue_id

    AND claimed_by IS NULL;

    IF NOT FOUND THEN

        RAISE EXCEPTION
        'Letter has already been claimed.';

    END IF;

    UPDATE letters

    SET

        status = 'claimed',

        current_holder = p_mailman,

        claimed_at = NOW()

    WHERE id = v_letter;

END;

$$;