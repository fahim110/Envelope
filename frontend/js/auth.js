// =======================================
// Epistolary Authentication Controller
// Part 1 - UI Switching
// =======================================

// ---------- DOM Elements ----------

const authForm = document.getElementById("authForm");

const usernameGroup = document.querySelectorAll(".registerOnly");

const switchButton = document.getElementById("switchButton");

const switchText = document.getElementById("switchText");

const submitBtn = document.getElementById("submitBtn");

const statusMessage = document.getElementById("statusMessage");

// Input Fields

const usernameInput = document.getElementById("username");

const emailInput = document.getElementById("email");

const passwordInput = document.getElementById("password");

const floorInput = document.getElementById("floor");

// -----------------------------

let registerMode = false;

// -----------------------------

function updateUI() {

    if(registerMode){

        // Show registration fields

        usernameGroup.forEach(field=>{
            field.classList.remove("hidden");
        });

        submitBtn.textContent = "Receive Postal Badge";

        switchText.textContent = "Already a Courier?";

        switchButton.textContent = "Login";

        statusMessage.textContent = "";

    }

    else{

        usernameGroup.forEach(field=>{
            field.classList.add("hidden");
        });

        submitBtn.textContent = "Enter Post Office";

        switchText.textContent = "New Courier?";

        switchButton.textContent = "Create Account";

        statusMessage.textContent = "";

    }

}

// -----------------------------

switchButton.addEventListener("click",()=>{

    registerMode = !registerMode;

    updateUI();

});

// -----------------------------

updateUI();


// =========================
// Status Message Helper
// =========================

function showStatus(message, color = "#8B0000") {

    statusMessage.textContent = message;
    statusMessage.style.color = color;

}

// =========================
// Loading Button
// =========================

function setLoading(isLoading){

    submitBtn.disabled = isLoading;

    if(isLoading){

        submitBtn.textContent = "Please Wait...";

    }else{

        submitBtn.textContent = registerMode ?
        "Receive Postal Badge" :
        "Enter Post Office";

    }

}

// ====================================
// Authentication
// ====================================

authForm.addEventListener("submit", async (e)=>{

    e.preventDefault();

    showStatus("");

    const email = emailInput.value.trim();

    const password = passwordInput.value;

    if(email === "" || password === ""){

        showStatus("Please fill in every required field.");

        return;

    }

    if(registerMode){

        await registerUser();

    }else{

        await loginUser();

    }

});


// ====================================
// Register
// ====================================

async function registerUser(){

    const username = usernameInput.value.trim();

    const floor = Number(floorInput.value);

    if(username.length < 3){

        showStatus("Username must contain at least 3 characters.");

        return;

    }

    setLoading(true);

    try{

        const {data,error} = await window.supabaseClient.auth.signUp({

            email: emailInput.value.trim(),

            password: passwordInput.value,

            options:{

                data:{
                    username:username,
                    current_floor:floor
                }

            }

        });

        if(error){

            throw error;

        }

        showStatus(
            "Registration successful! Please check your email to verify your account.",
            "green"
        );

        authForm.reset();

    }

    catch(err){

        showStatus(err.message);

    }

    finally{

        setLoading(false);

    }

}

// ====================================
// Login
// ====================================

async function loginUser(){

    setLoading(true);

    try{

        const {data,error} =
        await window.supabaseClient.auth.signInWithPassword({

            email:emailInput.value.trim(),

            password:passwordInput.value

        });

        if(error){

            throw error;

        }

        showStatus("Login Successful!", "green");

        setTimeout(()=>{

            window.location.href="dashboard.html";

        },1000);

    }

    catch(err){

        showStatus(err.message);

    }

    finally{

        setLoading(false);

    }

}