function readURL(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();

        reader.onload = function(e) {
            $('#upload-image').attr('src', e.target.result);
            $('#upload-image').attr('style',"display: block;");
        };

        reader.readAsDataURL(input.files[0]);
    }
}

$("#photo-file").change(function() {
    readURL(this);
});
