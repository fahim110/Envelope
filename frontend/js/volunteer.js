const container = document.getElementById("lettersContainer");

const logoutBtn = document.getElementById("logoutBtn");

async function loadLetters(){

    const {

        data:{session}

    } = await window.supabaseClient.auth.getSession();

    if(!session){

        window.location.href="index.html";

        return;

    }

    const {

        data,

        error

    } = await window.supabaseClient

    .from("available_letters")

    .select("*");

    if(error){

        container.innerHTML=`<p>${error.message}</p>`;

        return;

    }

    if(data.length===0){

        container.innerHTML="<h3>No letters waiting.</h3>";

        return;

    }

    container.innerHTML="";

    data.forEach(letter=>{

        const card=document.createElement("div");

        card.className="card";

        card.innerHTML=`

            <h2>${letter.username}</h2>

            <p><b>Department:</b> ${letter.department ?? "Unknown"}</p>

            <p><b>Floor:</b> ${letter.current_floor}</p>

            <button data-id="${letter.queue_id}">

                Claim Letter

            </button>

        `;

        container.appendChild(card);

    });

    document.querySelectorAll("button[data-id]")

    .forEach(btn=>{

        btn.addEventListener("click",claimLetter);

    });

}

async function claimLetter(e){

    const queueId=e.target.dataset.id;

    const {

        data:{session}

    }=await window.supabaseClient.auth.getSession();

    const {

        error

    }=await window.supabaseClient.rpc(

        "claim_letter",

        {

            p_queue_id:queueId,

            p_mailman:session.user.id

        }

    );

    if(error){

        alert(error.message);

        return;

    }

    loadLetters();

}

logoutBtn.addEventListener("click",async()=>{

    await window.supabaseClient.auth.signOut();

    window.location.href="index.html";

});

loadLetters();