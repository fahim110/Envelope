-- ===========================================
-- Module 021
-- Available Letters for Volunteers
-- ===========================================

CREATE OR REPLACE VIEW available_letters AS

SELECT

    q.id               AS queue_id,

    l.id               AS letter_id,

    l.recipient_id,

    p.username,

    p.department,

    p.current_floor,

    p.avatar_url,

    q.deposited_at

FROM post_office_queue q

JOIN letters l

ON q.letter_id = l.id

JOIN profiles p

ON l.recipient_id = p.id

WHERE

    q.claimed_by IS NULL

AND

    q.is_active = TRUE

AND

    l.status = 'at_post_office'

ORDER BY

    q.deposited_at ASC;