$(document).ready(function () {

    let endpoint = 'tidy';
    let host = window.location.host;
    let socket = new WebSocket("ws://" + host + '/' + endpoint);

    // send message from the form
    document.forms.publish.onsubmit = function() {
        let outgoingMessage = {
            css: this.message.value
        };

        socket.send(JSON.stringify(outgoingMessage));
        return false;
    };

    // message received - show the message in div#messages
    socket.onmessage = function(event) {
        let message = JSON.parse(event.data);

        let messageElem = document.createElement('div');
        messageElem.textContent = message["css"];
        document.getElementById('output').replaceChildren(messageElem);
    }
});
