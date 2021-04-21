use lib "/home/david/git/CSS-raku";
use Cro::HTTP::Log::File;
use Cro::HTTP::Server;
use Routes;

my $application = routes();

my Cro::Service $http = Cro::HTTP::Server.new(
    http => <1.1>,
    host => %*ENV<CSSTIDY_HOST> ||
        die("Missing CSSTIDY_HOST in environment"),
    port => %*ENV<CSSTIDY_PORT> ||
        die("Missing CSSTIDY_PORT in environment"),
##    tls => %(
##        private-key-file => %*ENV<CSSTIDY_TLS_KEY> ||
##            %?RESOURCES<fake-tls/server-key.pem> || "resources/fake-tls/server-key.pem",
##        certificate-file => %*ENV<CSSTIDY_TLS_CERT> ||
##            %?RESOURCES<fake-tls/server-crt.pem> || "resources/fake-tls/server-crt.pem",
##    ),
    :$application,
    after => [
        Cro::HTTP::Log::File.new(logs => $*OUT, errors => $*ERR)
    ]
);
$http.start;
say "Listening at https://%*ENV<CSSTIDY_HOST>:%*ENV<CSSTIDY_PORT>";
react {
    whenever signal(SIGINT) {
        say "Shutting down...";
        $http.stop;
        done;
    }
}
