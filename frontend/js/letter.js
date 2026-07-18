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

const anonymous = document.getElementById("anonymous");

const photo = document.getElementById("photo");

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
// Save Draft
// =======================================

draftBtn.addEventListener("click", async () => {

    const success = await saveDraft(false);

    if(success){

        alert("Draft saved successfully.");

    }

});

form.addEventListener("submit", async (e)=>{

    e.preventDefault();

    const letterId = await saveDraft(true);

    if(letterId){

        window.location.href = `qr.html?letter=${letterId}`;

    }

});

// =======================================

async function saveDraft(goToDrafts){

    const {

        data:{session}

    } = await window.supabaseClient.auth.getSession();

    // Check draft count only for NEW letters

    const {count} = await window.supabaseClient

        .from("letters")

        .select("*",{count:"exact",head:true})

        .eq("sender_id",session.user.id)

        .eq("status","draft");

    if(count>=5){

        alert("Maximum 5 drafts allowed.");

        return data.id;

    }

    // Find recipient

    const {

        data:recipient,

        error:recipientError

    } = await window.supabaseClient

        .from("profiles")

        .select("id")

        .eq("username",recipientInput.value.trim())

        .single();

    if(recipientError){

        alert("Recipient not found.");

        return false;

    }

    const {

        data,
    
        error
    
    } = await window.supabaseClient
    
        .from("letters")
    
        .insert({
    
            sender_id:session.user.id,
    
            recipient_id:recipient.id,
    
            title:titleInput.value.trim(),
    
            body:bodyInput.value.trim(),
    
            status:"draft",
    
            is_anonymous:anonymous.checked,
    
            has_attachment:photo.files.length>0
    
        })
    
        .select()
    
        .single();
    
    if(error){
    
        alert(error.message);
    
        return false;
    
    }

    if(!goToDrafts){

        form.reset();

        updateCounter();

    }

    return true;

}