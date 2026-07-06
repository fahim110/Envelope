-- ============================================================
-- Envelope Database v3
-- File: 014_rls.sql
-- ============================================================

--------------------------------------------------------
-- Enable RLS
--------------------------------------------------------

ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE qr_codes ENABLE ROW LEVEL SECURITY;
ALTER TABLE letters ENABLE ROW LEVEL SECURITY;
ALTER TABLE letter_history ENABLE ROW LEVEL SECURITY;
ALTER TABLE notifications ENABLE ROW LEVEL SECURITY;
ALTER TABLE attachments ENABLE ROW LEVEL SECURITY;
ALTER TABLE reports ENABLE ROW LEVEL SECURITY;

--------------------------------------------------------
-- Profiles
--------------------------------------------------------

CREATE POLICY "Users can view all profiles"
ON profiles
FOR SELECT
TO authenticated
USING (true);

CREATE POLICY "Users can update own profile"
ON profiles
FOR UPDATE
TO authenticated
USING (auth.uid() = id);

--------------------------------------------------------
-- QR Codes
--------------------------------------------------------

CREATE POLICY "Users can view own QR"
ON qr_codes
FOR SELECT
TO authenticated
USING (auth.uid() = user_id);

--------------------------------------------------------
-- Letters
--------------------------------------------------------

CREATE POLICY "Users can create letters"
ON letters
FOR INSERT
TO authenticated
WITH CHECK (auth.uid() = sender_id);

CREATE POLICY "Users can view own letters"
ON letters
FOR SELECT
TO authenticated
USING (
    auth.uid() = sender_id OR
    auth.uid() = recipient_id OR
    auth.uid() = current_holder
);

CREATE POLICY "Sender can edit drafts"
ON letters
FOR UPDATE
TO authenticated
USING (
    auth.uid() = sender_id
    AND status = 'draft'
);

--------------------------------------------------------
-- Notifications
--------------------------------------------------------

CREATE POLICY "Users view own notifications"
ON notifications
FOR SELECT
TO authenticated
USING (auth.uid() = user_id);

CREATE POLICY "Users update own notifications"
ON notifications
FOR UPDATE
TO authenticated
USING (auth.uid() = user_id);

--------------------------------------------------------
-- Attachments
--------------------------------------------------------

CREATE POLICY "Users view attachments of their letters"
ON attachments
FOR SELECT
TO authenticated
USING (

    EXISTS (

        SELECT 1

        FROM letters

        WHERE letters.id = attachments.letter_id

        AND (

            letters.sender_id = auth.uid()
            OR letters.recipient_id = auth.uid()
            OR letters.current_holder = auth.uid()

        )

    )

);

--------------------------------------------------------
-- Letter History
--------------------------------------------------------

CREATE POLICY "Users view history of their letters"
ON letter_history
FOR SELECT
TO authenticated
USING (

    EXISTS (

        SELECT 1

        FROM letters

        WHERE letters.id = letter_history.letter_id

        AND (

            letters.sender_id = auth.uid()
            OR letters.recipient_id = auth.uid()
            OR letters.current_holder = auth.uid()

        )

    )

);

--------------------------------------------------------
-- Reports
--------------------------------------------------------

CREATE POLICY "Users create reports"
ON reports
FOR INSERT
TO authenticated
WITH CHECK (auth.uid() = reporter_id);

CREATE POLICY "Users view own reports"
ON reports
FOR SELECT
TO authenticated
USING (auth.uid() = reporter_id);