// ==========================================
// Envelope Volunteer Mailman
// ==========================================

const waitingContainer =
document.getElementById("waitingContainer");

const bagContainer =
document.getElementById("bagContainer");

const waitingCount =
document.getElementById("waitingCount");

const bagCount =
document.getElementById("bagCount");

const logoutBtn =
document.getElementById("logoutBtn");

const scanStatus =
document.getElementById("scanStatus");

// ==========================================

let currentVolunteer = null;

let currentDeliveryLetter = null;

let html5QrCode = null;

// ==========================================

initialize();

// ==========================================

async function initialize(){

    const {

        data:{session}

    } = await window.supabaseClient.auth.getSession();

    if(!session){

        window.location.href="index.html";

        return;

    }

    currentVolunteer = session.user.id;

    await loadWaitingLetters();

    await loadMailBag();

}

// ==========================================
// Waiting Letters
// ==========================================

async function loadWaitingLetters(){

    const {

        data,

        error

    } = await window.supabaseClient

    .from("available_letters")

    .select("*");

    if(error){

        waitingContainer.innerHTML =
        `<p>${error.message}</p>`;

        return;

    }

    waitingCount.textContent = data.length;

    if(data.length===0){

        waitingContainer.innerHTML=

        `<p>No letters waiting.</p>`;

        return;

    }

    waitingContainer.innerHTML="";

    data.forEach(letter=>{

        const card=document.createElement("div");

        card.className="card";

        card.innerHTML=`

            <h3>${letter.username}</h3>

            <p>

                Department:
                ${letter.department ?? "Unknown"}

            </p>

            <p>

                Floor:
                ${letter.current_floor}

            </p>

            <button
                class="claimBtn"
                data-id="${letter.queue_id}">

                Claim Letter

            </button>

        `;

        waitingContainer.appendChild(card);

    });

    document

    .querySelectorAll(".claimBtn")

    .forEach(btn=>{

        btn.addEventListener(

            "click",

            claimLetter

        );

    });

}

// ==========================================
// Claim Letter
// ==========================================

async function claimLetter(e){

    const queueId =

    e.target.dataset.id;

    const {

        error

    } = await window.supabaseClient.rpc(

        "claim_letter",

        {

            p_queue_id:queueId,

            p_mailman:currentVolunteer

        }

    );

    if(error){

        alert(error.message);

        return;

    }

    await loadWaitingLetters();

    await loadMailBag();

}

// ==========================================
// My Mail Bag
// ==========================================

async function loadMailBag(){

    const {

        data,

        error

    } = await window.supabaseClient

    .from("volunteer_letters")

    .select("*")

    .eq("current_holder",currentVolunteer);

    if(error){

        bagContainer.innerHTML=

        `<p>${error.message}</p>`;

        return;

    }

    bagCount.textContent=data.length;

    if(data.length===0){

        bagContainer.innerHTML=

        `<p>No letters in your bag.</p>`;

        return;

    }

    bagContainer.innerHTML="";

    data.forEach(letter=>{

        const card=document.createElement("div");

        card.className="card";

        card.innerHTML=`

            <h3>${letter.username}</h3>

            <p>

                Department:
                ${letter.department ?? "Unknown"}

            </p>

            <p>

                Floor:
                ${letter.current_floor}

            </p>

            <button

                class="deliverBtn"

                data-letter="${letter.id}"

                data-recipient="${letter.recipient_id}"

            >

                📷 Deliver

            </button>

        `;

        bagContainer.appendChild(card);

    });

    document

    .querySelectorAll(".deliverBtn")

    .forEach(btn=>{

        btn.addEventListener(

            "click",

            startDelivery

        );

    });

}

// ==========================================
// Start Delivery
// ==========================================

async function startDelivery(e){

    currentDeliveryLetter={

        letter:

        e.target.dataset.letter,

        recipient:

        e.target.dataset.recipient

    };

    scanStatus.innerHTML=

    "Opening camera...";

    if(html5QrCode){

        try{

            await html5QrCode.stop();

        }

        catch{}

    }

    html5QrCode=

    new Html5Qrcode("reader");

    try{

        await html5QrCode.start(

            {

                facingMode:"environment"

            },

            {

                fps:10,

                qrbox:250

            },

            qrSuccess,

            ()=>{}

        );

    }

    catch(err){

        scanStatus.innerHTML=

        err.message;

    }

}

// ==========================================
// QR Scan Success
// ==========================================

async function qrSuccess(decodedText){

    try{

        await html5QrCode.stop();

    }

    catch{}

    let qr;

    try{

        qr = JSON.parse(decodedText);

    }

    catch{

        scanStatus.innerHTML =

        "❌ Invalid QR Code";

        return;

    }

    // Verify Envelope QR

    if(

        qr.app !== "Envelope" ||

        qr.type !== "recipient"

    ){

        scanStatus.innerHTML =

        "❌ This is not an Envelope Recipient QR.";

        return;

    }

    // Verify correct recipient

    if(

        qr.user_id !== currentDeliveryLetter.recipient

    ){

        scanStatus.innerHTML =

        "❌ Wrong recipient!";

        return;

    }

    scanStatus.innerHTML =

    "✅ Recipient verified.<br>Delivering letter...";

    // Call SQL Function

    const {

        error

    } = await window.supabaseClient.rpc(

        "deliver_letter",

        {

            p_letter_id:

            currentDeliveryLetter.letter,

            p_volunteer:

            currentVolunteer,

            p_recipient:

            currentDeliveryLetter.recipient

        }

    );

    if(error){

        scanStatus.innerHTML =

        error.message;

        return;

    }

    scanStatus.innerHTML =

    "🎉 Letter Delivered Successfully!";

    currentDeliveryLetter = null;

    await loadMailBag();

    await loadWaitingLetters();

}

// ==========================================
// Logout
// ==========================================

logoutBtn.addEventListener(

    "click",

    async()=>{

        if(html5QrCode){

            try{

                await html5QrCode.stop();

            }

            catch{}

        }

        await window.supabaseClient.auth.signOut();

        window.location.href="index.html";

    }

);