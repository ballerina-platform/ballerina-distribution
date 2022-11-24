import ballerina/http;

type Album readonly & record {|
    string title;
    string artist;
|};

// An HTTP listener can be configured to accept new connections that are
// secured via mutual SSL.
// The `http:ListenerSecureSocket` record provides the SSL-related listener configurations.
listener http:Listener securedEP = new(9090,
    secureSocket = {
        key: {
            certFile: "../resource/path/to/public.crt",
            keyFile: "../resource/path/to/private.key"
        },
        // Enables mutual SSL.
        mutualSsl: {
            verifyClient: http:REQUIRE,
            cert: "../resource/path/to/public.crt"
        }
    }
);

service / on securedEP {
    resource function get albums() returns Album[] {
        return [
            {title: "Blue Train", artist: "John Coltrane"},
            {title: "Jeru", artist: "Gerry Mulligan"}
        ];
    }
}
