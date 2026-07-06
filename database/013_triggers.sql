-- ============================================================
-- Envelope Database v3
-- File: 013_triggers.sql
-- ============================================================

--------------------------------------------------------
-- Automatically create profile after signup
--------------------------------------------------------

DROP TRIGGER IF EXISTS on_auth_user_created
ON auth.users;

CREATE TRIGGER on_auth_user_created

AFTER INSERT

ON auth.users

FOR EACH ROW

EXECUTE FUNCTION create_profile();

--------------------------------------------------------
-- Give every new user a QR code
--------------------------------------------------------

DROP TRIGGER IF EXISTS create_qr_after_profile
ON profiles;

CREATE TRIGGER create_qr_after_profile

AFTER INSERT

ON profiles

FOR EACH ROW

EXECUTE FUNCTION create_user_qr();

--------------------------------------------------------
-- Automatically update updated_at
--------------------------------------------------------

DROP TRIGGER IF EXISTS update_profiles_updated_at
ON profiles;

CREATE TRIGGER update_profiles_updated_at

BEFORE UPDATE

ON profiles

FOR EACH ROW

EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_letters_updated_at
ON letters;

CREATE TRIGGER update_letters_updated_at

BEFORE UPDATE

ON letters

FOR EACH ROW

EXECUTE FUNCTION update_updated_at_column();