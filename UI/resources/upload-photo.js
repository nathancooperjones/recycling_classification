var photo_url;

// function readURL(input) {
//     if (input.files && input.files[0]) {
//         var reader = new FileReader();

//         reader.onload = function(e) {
//             photo_url = e.target.result;
//             $('#upload-image').attr('src', e.target.result);
//             $('#upload-image').attr('style',"display: block;");
//         };

//         reader.readAsDataURL(input.files[0]);
//     }
// }

var blob_url;

window.addEventListener('load', function() {
    document.querySelector('input[type="file"]').addEventListener('change', function() {
        if (this.files && this.files[0]) {
            var img = document.querySelector('img');  // $('img')[0]
            img.src = URL.createObjectURL(this.files[0]); // set src to blob url
            img.style.display = "block";
            blob_url = img.src;
        }
    });
});

// $("#photo-file").change(function() {
//     readURL(this);
// });

function uploadFile() {
    var blobFile = $('#photo-file');
    var fd = new FormData();
    fd.append("data",blob_url);
    $.ajax({
        url: "save-photo",
        type: "POST",
        data: fd,
        processData: false,
        contentType: false,
        error: function(jqXHR, textStatus, errorMessage) {
            console.log("Upload failed"); // Optional
        }
    }).done(function(data) {
        console.log("uploaded photo");
    });
}

function PostRecording(){
    // Posts the recorded audio to '/upload-wav'
    recorder && recorder.exportWAV(function(blob){
        // Do something with blob
        var fd = new FormData();
        var chatroom = document.getElementById("chatroom");
        var chatroom_id = chatroom.getAttribute("value");
        fd.append('cr-id', chatroom_id);
        fd.append('data', blob);
        $.ajax({
            type: 'POST',
            url: 'upload-wav',
            data: fd,
            processData: false,
            contentType: false
        }).done(function(data) {
            console.log("uploaded wav");
        });
    });
}
