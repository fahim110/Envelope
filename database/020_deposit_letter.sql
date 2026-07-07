-- ===========================================
-- Module 019
-- Fixed Postal QR Locations
-- ===========================================

CREATE TABLE IF NOT EXISTS public.postal_locations
(
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    name TEXT NOT NULL,

    qr_code TEXT UNIQUE NOT NULL,

    location TEXT,

    created_at TIMESTAMPTZ DEFAULT now()
);

INSERT INTO public.postal_locations
(name, qr_code, location)

VALUES
(
    'Central Post Office',
    'Envelope://postoffice',
    'Floor 6 Cafeteria'
)

ON CONFLICT (qr_code) DO NOTHING;


INSERT INTO public.postal_locations
(name, qr_code, location)

VALUES
(
    'Volunteer Mailman Station',
    'Envelope://volunteer',
    'Floor 6 Cafeteria'
)

ON CONFLICT (qr_code) DO NOTHING;