$(document).ready(function () {

    // send message from the form
    $("#publish").submit(function(event){
        event.preventDefault(); // avoid to execute the actual submit of the form.

        $.ajax({
            url: '/tidy',
            type: 'POST',
            data: $(this).serialize(),
            success: function(resp)
           {
               // message received - show the message in div#messages
               let messageElem = document.createElement('div');
               let css_tidied = resp["css"];
               let warnings = resp["warnings"];
               messageElem.textContent = css_tidied;
               document.getElementById('output').replaceChildren(messageElem);
               if (warnings.length) {
                   // stub
                   alert("ouch! " + warnings[0] + '...');
               }
           }
        });
    });

});
