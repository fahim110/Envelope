// =======================================
// Envelope - Supabase Configuration
// =======================================

const SUPABASE_URL = "https://ivpjvxuimmnlldbvtmmd.supabase.co";

const SUPABASE_ANON_KEY =
"sb_publishable_lUbxlZzpySVlnN22Ejn-tA_GFj_P-m3";

// Make the client globally available
window.supabaseClient = window.supabase.createClient(
    SUPABASE_URL,
    SUPABASE_ANON_KEY
);

console.log("Supabase connected.");