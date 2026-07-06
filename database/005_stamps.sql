-- ============================================================
-- Envelope Database v3
-- File: 005_stamps.sql
-- ============================================================

--------------------------------------------------------
-- Stamps
--------------------------------------------------------

CREATE TABLE IF NOT EXISTS stamps (

    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    name VARCHAR(100) NOT NULL UNIQUE,

    description TEXT,

    image_url TEXT,

    rarity rarity_level NOT NULL DEFAULT 'common',

    price INTEGER NOT NULL DEFAULT 0,

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()

);

--------------------------------------------------------
-- User Stamp Collection
--------------------------------------------------------

CREATE TABLE IF NOT EXISTS user_stamps (

    user_id UUID NOT NULL
        REFERENCES profiles(id)
        ON DELETE CASCADE,

    stamp_id UUID NOT NULL
        REFERENCES stamps(id)
        ON DELETE CASCADE,

    quantity INTEGER NOT NULL DEFAULT 1
        CHECK(quantity >= 0),

    acquired_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    PRIMARY KEY(user_id, stamp_id)

);

--------------------------------------------------------
-- Indexes
--------------------------------------------------------

CREATE INDEX IF NOT EXISTS idx_stamp_rarity
ON stamps(rarity);

CREATE INDEX IF NOT EXISTS idx_user_stamp_user
ON user_stamps(user_id);

--------------------------------------------------------
-- Starter Stamps
--------------------------------------------------------

INSERT INTO stamps
(name, description, rarity, price)

SELECT
'Classic Envelope',
'The default stamp every student owns.',
'common',
0

WHERE NOT EXISTS (

    SELECT 1
    FROM stamps
    WHERE name='Classic Envelope'

);

INSERT INTO stamps
(name, description, rarity, price)

SELECT
'Blue Air Mail',
'Traditional blue border stamp.',
'common',
25

WHERE NOT EXISTS (

    SELECT 1
    FROM stamps
    WHERE name='Blue Air Mail'

);

INSERT INTO stamps
(name, description, rarity, price)

SELECT
'Golden Courier',
'A rare collector stamp.',
'rare',
500

WHERE NOT EXISTS (

    SELECT 1
    FROM stamps
    WHERE name='Golden Courier'

);

INSERT INTO stamps
(name, description, rarity, price)

SELECT
'Ghost Seal',
'A mysterious stamp unlocked through ghost letters.',
'legendary',
0

WHERE NOT EXISTS (

    SELECT 1
    FROM stamps
    WHERE name='Ghost Seal'

);