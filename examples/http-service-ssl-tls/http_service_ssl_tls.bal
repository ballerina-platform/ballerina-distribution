import ballerina/http;

type Album readonly & record {|
    string title;
    string artist;
|};

// An HTTP listener can be configured to communicate through HTTPS as well.
// To secure a listener using HTTPS, the listener needs to be configured with
// a certificate file and a private key file for the listener.
// The `http:ListenerSecureSocket` record provides the SSL-related listener configurations of the listener.
listener http:Listener securedEP = new(9090,
    secureSocket = {
        key: {
            certFile: "../resource/path/to/public.crt",
            keyFile: "../resource/path/to/private.key"
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
