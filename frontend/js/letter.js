// =======================================
// Envelope Letter Composer
// Part 1
// =======================================

const form = document.getElementById("letterForm");

const recipientInput = document.getElementById("recipient");

const titleInput = document.getElementById("title");

const bodyInput = document.getElementById("body");

const wordCounter = document.getElementById("wordCount");

const draftBtn = document.getElementById("draftBtn");

const continueBtn = document.getElementById("continueBtn");

const MAX_WORDS = 300;

// =======================================
// Authentication
// =======================================

async function checkUser(){

    const {

        data:{session}

    } = await window.supabaseClient.auth.getSession();

    if(!session){

        window.location.href="index.html";

        return;
    }

}

checkUser();


// =======================================
// Word Counter
// =======================================

function countWords(text){

    text = text.trim();

    if(text===""){

        return 0;

    }

    return text.split(/\s+/).length;

}

function updateCounter(){

    const words = countWords(bodyInput.value);

    wordCounter.textContent = `${words} / ${MAX_WORDS} Words`;

    if(words>MAX_WORDS){

        wordCounter.style.color="red";

        continueBtn.disabled=true;

        draftBtn.disabled=true;

    }

    else{

        wordCounter.style.color="#666";

        continueBtn.disabled=false;

        draftBtn.disabled=false;

    }

}

bodyInput.addEventListener("input",updateCounter);

updateCounter();


// =======================================
// Temporary Buttons
// =======================================

draftBtn.addEventListener("click",()=>{

    alert("Draft system coming next.");

});

form.addEventListener("submit",(e)=>{

    e.preventDefault();

    alert("Central Post Office workflow coming next.");

});