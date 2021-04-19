$(document).ready(function () {

    let endpoint = 'tidy';
    let host = window.location.host;
    let socket = new WebSocket("ws://" + host + '/' + endpoint);

    // send message from the form
    document.forms.publish.onsubmit = function() {
        let outgoingMessage = this.message.value;

        socket.send(outgoingMessage);
        return false;
    };

    // message received - show the message in div#messages
    socket.onmessage = function(event) {
        let message = event.data;

        let messageElem = document.createElement('div');
        messageElem.textContent = message;
        document.getElementById('output').replaceChildren(messageElem);
    }
});
