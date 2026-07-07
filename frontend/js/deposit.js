const container = document.getElementById("lettersContainer");

loadLetters();

async function loadLetters(){

    const {

        data:{session}

    }=await window.supabaseClient.auth.getSession();

    if(!session){

        window.location="index.html";

        return;

    }

    const {

        data,

        error

    }=await window.supabaseClient

    .from("letters")

    .select("*")

    .eq("sender_id",session.user.id)

    .eq("status","draft");

    if(error){

        container.innerHTML=error.message;

        return;

    }

    if(data.length===0){

        container.innerHTML="<h3>No draft letters.</h3>";

        return;

    }

    container.innerHTML="";

    data.forEach(letter => {

        const card = document.createElement("div");
    
        card.className = "card";
    
        card.innerHTML = `
    
            <h3>${letter.title}</h3>
    
            <p>${letter.body.substring(0,120)}...</p>
    
            <button onclick="deposit('${letter.id}')">
    
                Deposit at Central Post Office
    
            </button>
    
        `;
    
        container.appendChild(card);
    
    });

}

async function deposit(letterId){

    const {

        data:{session}

    }=await window.supabaseClient.auth.getSession();

    const {

        error

    }=await window.supabaseClient.rpc(

        "deposit_letter",

        {

            p_letter_id:letterId,

            p_sender_id:session.user.id

        }

    );

    if(error){

        alert(error.message);

        return;

    }

    alert("Letter deposited successfully.");

    loadLetters();

}