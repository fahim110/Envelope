// ======================================
// Envelope Personal QR
// ======================================

generateQR();

async function generateQR(){

    const {

        data:{session}

    } = await window.supabaseClient.auth.getSession();

    if(!session){

        window.location.href="index.html";

        return;

    }

    const {

        data:profile,

        error

    } = await window.supabaseClient

        .from("profiles")

        .select("username")

        .eq("id",session.user.id)

        .single();

    if(error){

        document.getElementById("status").innerHTML = error.message;

        return;

    }

    document.getElementById("username").innerHTML =

    profile.username;

    const qrData = JSON.stringify({

        app:"Envelope",

        version:1,

        type:"recipient",

        user_id:session.user.id

    });

    QRCode.toCanvas(

        qrData,

        {

            width:250

        },

        function(err,canvas){

            if(err){

                console.log(err);

                return;

            }

            document

                .getElementById("qrcode")

                .appendChild(canvas);

        }

    );

}