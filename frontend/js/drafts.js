// ======================================
// Envelope Draft Manager
// ======================================

const draftContainer = document.getElementById("draftContainer");
const draftCount = document.getElementById("draftCount");

const MAX_DRAFTS = 5;

loadDrafts();

// ======================================

async function loadDrafts(){

    const {

        data:{session}

    } = await window.supabaseClient.auth.getSession();

    if(!session){

        window.location.href = "index.html";

        return;

    }

    // Get drafts with recipient username

    const {data,error} = await window.supabaseClient

    .from("letters")

    .select(`
        id,
        title,
        body,
        recipient_id,
        profiles!letters_recipient_id_fkey
        (
            username
        )
    `)

    .eq("sender_id",session.user.id)

    .eq("status","draft")

    .order("created_at",{ascending:false});

    if(error){

        draftContainer.innerHTML = error.message;

        return;

    }

    draftCount.textContent =
    `${data.length} / ${MAX_DRAFTS} Draft Letters`;

    if(data.length===0){

        draftContainer.innerHTML=`
            <h3>No Draft Letters Yet</h3>
        `;

        return;

    }

    draftContainer.innerHTML="";
    console.log(data);

    data.forEach(letter=>{

        const card=document.createElement("div");

        card.className="card";

        card.innerHTML=`

            <h3>${letter.title}</h3>

            <p>

                <b>To:</b>

                ${letter.profiles.username}

            </p>

            <p>

                ${letter.body.substring(0,120)}...

            </p>

            <div class="buttons">

                <button onclick="editDraft('${letter.id}')">

                    Edit

                </button>

                <button onclick="depositDraft('${letter.id}')">

                    Deposit

                </button>

                <button onclick="deleteDraft('${letter.id}')">

                    Delete

                </button>

            </div>

        `;

        draftContainer.appendChild(card);

    });

}

// ======================================

function editDraft(id){

    window.location.href =
    `letter.html?id=${id}`;

}

// ======================================

async function depositDraft(id){

    if(!confirm("Deposit this letter at the Central Post Office?")){

        return;

    }

    const {

        data:{session}

    } = await window.supabaseClient.auth.getSession();

    const {error}=await window.supabaseClient.rpc(

        "deposit_letter",

        {

            p_letter_id:id,

            p_sender_id:session.user.id

        }

    );

    if(error){

        alert(error.message);

        return;

    }

    alert("Letter deposited!");

    loadDrafts();

}

// ======================================

async function deleteDraft(id){

    if(!confirm("Delete this draft?")){
        return;
    }

    console.log("Deleting:", id);

    const { error } = await window.supabaseClient
        .from("letters")
        .delete()
        .match({
            id: id
        });

    if(error){
        console.error(error);
        alert(error.message);
        return;
    }

    alert("Draft deleted.");

    loadDrafts();

}