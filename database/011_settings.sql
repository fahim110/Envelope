-- ============================================================
-- Envelope Database v3
-- File: 011_settings.sql
-- ============================================================

CREATE TABLE IF NOT EXISTS system_settings (

    setting_key VARCHAR(100) PRIMARY KEY,

    setting_value TEXT NOT NULL,

    description TEXT,

    updated_at TIMESTAMPTZ
        NOT NULL DEFAULT NOW()

);

--------------------------------------------------------
-- Default Settings
--------------------------------------------------------

INSERT INTO system_settings
(setting_key, setting_value, description)

VALUES

('max_letter_words','300','Maximum words allowed per letter'),

('max_photo_size_mb','5','Maximum photo upload size'),

('allow_anonymous_letters','true','Allow anonymous letters'),

('allow_volunteer_mailmen','true','Enable volunteer mailmen'),

('central_post_office_floor','6','Location of Central Post Office'),

('starting_coins','100','Coins given to new users'),

('starting_level','1','Default player level')

ON CONFLICT (setting_key) DO NOTHING;