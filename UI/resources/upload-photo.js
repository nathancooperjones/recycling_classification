function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function(e) {
            photo_url = e.target.result;
            $('#upload-image').attr('src', e.target.result);
            $('#upload-image').attr('style',"display: block;");
        };

        reader.readAsDataURL(input.files[0]);
    }
}

$("#photo-file").change(function() {
    readURL(this);
});

$('#photo-file').change(function(){
    var frm = new FormData();
    frm.append('#photo-file', input.files[0]);
    $.ajax({
        method: 'POST',
        address: 'resources/image',
        data: frm,
        contentType: false,
        processData: false,
        cache: false
    });
});


function uploadFile() {
    var blobFile = $('#photo-file');
    const mediaStream = new MediaStream();
    blobFile.srcObject = mediaStream;
    var binary_data = [];
    binary_data.push(blobFile);
    var blob_url = URL.createObjectURL(new Blob(binary_data,
                                                {type: "application/upload"}));
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
