use Cro::HTTP::Router;
use Cro::HTTP::Router::WebSocket;
use CSSTidy;
use JSON::Fast;

sub routes() is export {

    route {
        get -> {
          static 'static/index.html';
        }

        get -> 'js', *@path {
            static 'static/js', @path
        }
        post -> 'tidy' {
            request-body -> %req {
                my Str:D $css = %req<css>;
                my CSSTidy $tidier .= new: :$css;
                my Bool $optimize = %req<mode> eq "optimize";
                my Bool $terse        = ! %req<pretty>;
                my Pair $color = 'color-' ~ %req<color> => True;

                $css = $tidier.tidy: :$optimize, :$terse, |$color;
                my @warnings = $tidier.warnings>>.message;
                content 'application/json', %( :$css, :@warnings, );
            }
        }
    }
}
