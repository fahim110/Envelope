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

    if (error) {

        alert("Profile not found.");
    
        console.error(error);
    
        return;
    
    }

    // -----------------------------
    // Fill UI
    // -----------------------------

    welcomeText.textContent =
        `Welcome back, ${profile.username}!`;

    coinsText.textContent =profile.coins;
    
    reputationText.textContent =profile.reputation;

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