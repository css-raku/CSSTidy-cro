$(document).ready(function () {

    // send message from the form
    $("#publish").submit(function(event){
        event.preventDefault(); // avoid to execute the actual submit of the form.
        $('#submit').prop("disabled", true);

        $.ajax({
            url: '/tidy',
            type: 'POST',
            data: $(this).serialize(),
            success: function(resp) {
               // message received - show the message in div#messages
               let messageElem = document.createElement('div');
               let css_tidied = resp["css"];
               let warnings = resp["warnings"];
               messageElem.textContent = css_tidied;
               $('#css').val(css_tidied);
               if (warnings.length) {
                   $('#warnings').text( warnings.join("\n") );
                   $('#warnings').show();
               }
               else {
                   $('#warnings').hide();
                   $('#warnings').text('');
               }
               $('#submit').prop("disabled", false);
            },
            error: function(req, status, err) {
                alert("ouch! " + status);
               $('#submit').prop("disabled", false);
            },
        });
    });

});
