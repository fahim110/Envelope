// ==========================================
// Envelope
// Central Post Office QR Scanner
// ==========================================

const params = new URLSearchParams(window.location.search);

const letterId = params.get("letter");

const scanBtn = document.getElementById("scanBtn");

const status = document.getElementById("status");

// ==========================================

scanBtn.addEventListener("click", startScanner);

// ==========================================

async function startScanner(){

    scanBtn.disabled = true;

    status.innerHTML = "Opening camera...";

    const html5QrCode = new Html5Qrcode("reader");

    try{

        await html5QrCode.start(

            {

                facingMode:"environment"

            },

            {

                fps:10,

                qrbox:250

            },

            async(decodedText)=>{

                await html5QrCode.stop();

                verifyQRCode(decodedText);

            },

            ()=>{}

        );

    }

    catch(err){

        status.innerHTML = err.message;

        scanBtn.disabled = false;

    }

}

// ==========================================

async function verifyQRCode(decodedText){

    let qr;

    try{

        qr = JSON.parse(decodedText);

    }

    catch{

        status.innerHTML = "❌ Invalid QR Code";

        scanBtn.disabled = false;

        return;

    }

    if(

        qr.app !== "Envelope" ||
    
        qr.type !== "post_office" ||
    
        qr.id !== "floor6"
    
    ){

        status.innerHTML =

        "❌ This is NOT an official Envelope Post Office QR.";

        scanBtn.disabled = false;

        return;

    }

    status.innerHTML =

    "📮 Official QR Verified.<br>Depositing Letter...";

    const {

        data:{session}

    } = await window.supabaseClient.auth.getSession();

    if(!session){

        window.location.href="index.html";

        return;

    }

    const {error} = await window.supabaseClient.rpc(

        "deposit_letter",

        {

            p_letter_id:letterId,

            p_sender_id:session.user.id

        }

    );

    if(error){

        status.innerHTML = error.message;

        scanBtn.disabled = false;

        return;

    }

    status.innerHTML =

    "✅ Letter successfully deposited!";

    setTimeout(()=>{

        window.location.href="dashboard.html";

    },1500);

}