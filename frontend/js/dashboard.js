// ==========================================
// Epistolary Dashboard
// ==========================================

const welcomeText = document.getElementById("welcomeText");
const coinsText = document.getElementById("coins");
const reputationText = document.getElementById("reputation");
const floorText = document.getElementById("floor");
const logoutBtn = document.getElementById("logoutBtn");

// ==========================================

async function loadDashboard() {

    // Check current session

    const {

        data: { session }

    } = await window.supabaseClient.auth.getSession();

    if (!session) {

        window.location.href = "index.html";
        return;

    }

    const user = session.user;

    // -----------------------------
    // Check if profile exists
    // -----------------------------

    let { data: profile, error } = await window.supabaseClient

        .from("profiles")

        .select("*")

        .eq("id", user.id)

        .single();

    // -----------------------------------
    // Profile doesn't exist yet
    // -----------------------------------

    if (error || !profile) {

        const username =
            user.user_metadata.username || "Courier";

        const floor =
            user.user_metadata.current_floor || 1;

        const { error: insertError } =
            await window.supabaseClient

                .from("profiles")

                .insert({

                    id: user.id,

                    username: username,

                    current_floor: floor

                });

        if (insertError) {

            alert(insertError.message);

            return;

        }

        // Reload profile

        const result = await window.supabaseClient

            .from("profiles")

            .select("*")

            .eq("id", user.id)

            .single();

        profile = result.data;

    }

    // -----------------------------
    // Fill UI
    // -----------------------------

    welcomeText.textContent =
        `Welcome back, ${profile.username}!`;

    coinsText.textContent =
        profile.currency_balance;

    reputationText.textContent =
        profile.sender_reputation_score;

    floorText.textContent =
        profile.current_floor;

}

// ==========================================

logoutBtn.addEventListener("click", async () => {

    await window.supabaseClient.auth.signOut();

    window.location.href = "index.html";

});

// ==========================================

loadDashboard();