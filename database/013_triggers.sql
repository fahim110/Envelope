CREATE OR REPLACE FUNCTION public.create_profile()
RETURNS trigger
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN

    INSERT INTO public.profiles
    (
        id,
        username,
        current_floor
    )
    VALUES
    (
        NEW.id,
        COALESCE(NEW.raw_user_meta_data->>'username', 'Courier'),
        COALESCE((NEW.raw_user_meta_data->>'current_floor')::integer, 6)
    );

    RETURN NEW;

END;
$$;