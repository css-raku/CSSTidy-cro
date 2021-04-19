use Cro::HTTP::Router;
use Cro::HTTP::Router::WebSocket;
use CSSTidy;

sub routes() is export {

    route {
        get -> {
          static 'static/index.html';
        }

        get -> 'js', *@path {
            static 'static/js', @path
        }
        get -> 'tidy' {
            # For each request for a web socket...
            my $chat = Supplier.new;
            web-socket -> $incoming {
                # We start this bit of reactive logic...
                supply {
                    # Whenever we get a message on the socket, we emit it into the
                    # $chat Supplier
                    whenever $incoming -> $message {
                        $chat.emit(await $message.body-text);
                    }
                    # Whatever is emitted on the $chat Supplier (shared between all)
                    # web sockets), we send on this web socket.
                    whenever $chat -> $text {
                        my CSSTidy $tidier .= new();
                        emit $tidier.optimize($text);
                    }
                }
            }
        }
    }
}
