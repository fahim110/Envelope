create or replace function create_deposit_qr(p_letter uuid)
returns uuid
language plpgsql
as
$$

declare

    new_token uuid;

begin

    insert into qr_tokens
    (
        letter_id,
        qr_type
    )

    values
    (
        p_letter,
        'deposit'
    )

    returning token
    into new_token;

    update letters

    set status='ready_for_deposit'

    where id=p_letter;

    return new_token;

end;

$$;