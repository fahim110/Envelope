// ======================================
// Central Post Office
// ======================================

const params = new URLSearchParams(window.location.search);

const letterId = params.get("letter");

const recipientName = document.getElementById("recipientName");
const letterTitle = document.getElementById("letterTitle");

const startScanner = document.getElementById("startScanner");

const reader = document.getElementById("reader");

const status = document.getElementById("status");

let qrScanner = null;

// ======================================

loadLetter();

// ======================================

async function loadLetter(){

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

    .from("letters")

    .select(`
        title,
        recipient_id,
        profiles!letters_recipient_id_fkey
        (
            username
        )
    `)

    .eq("id",letterId)

    .single();

    if(error){

        status.innerHTML=error.message;

        return;

    }

    recipientName.innerHTML=
        "📨 To: " + data.profiles.username;

    letterTitle.innerHTML=data.title;

}

// ======================================

startScanner.addEventListener("click",startQRScanner);

// ======================================

function startQRScanner(){

    startScanner.style.display="none";

    reader.style.display="block";

    status.innerHTML="Point your camera at the Central Post Office QR.";

    qrScanner=new Html5Qrcode("reader");

    qrScanner.start(

        {

            facingMode:"environment"

        },

        {

            fps:10,

            qrbox:250

        },

        qrSuccess,

        qrError

    );

}

// ======================================

async function qrSuccess(decodedText){

    try{

        const qr=JSON.parse(decodedText);
        
        console.log(qr);
        alert(JSON.stringify(qr));

        if(

            qr.app!=="Envelope" ||

            qr.type!=="post_office" ||

            qr.hub!=="central_floor6"

        ){

            status.innerHTML="❌ Invalid Central Post Office QR";

            return;

        }

        await qrScanner.stop();

        status.innerHTML="✅ QR verified.";

        await deposit();

    }

    catch{

        status.innerHTML="❌ Invalid QR Code";

    }

}

// ======================================

function qrError(){

}

// ======================================

async function deposit(){

    const {

        data:{session}

    } = await window.supabaseClient.auth.getSession();

    const {

        error

    } = await window.supabaseClient.rpc(

        "deposit_letter",

        {

            p_letter_id:letterId,

            p_sender_id:session.user.id

        }

    );

    if(error){

        status.innerHTML=error.message;

        startScanner.style.display="block";

        return;

    }

    status.innerHTML="📮 Letter successfully deposited!";

    setTimeout(()=>{

        window.location.href="dashboard.html";

    },1800);

}