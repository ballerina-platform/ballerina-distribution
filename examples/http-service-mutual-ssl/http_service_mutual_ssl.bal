import ballerina/http;

// An HTTP listener can be configured to accept new connections that are
// secured via mutual SSL.
// The `http:ListenerSecureSocket` record provides the SSL-related listener configurations.
// For details, see https://lib.ballerina.io/ballerina/http/latest/records/ListenerSecureSocket.
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

service /foo on securedEP {
    resource function get bar() returns string {
        return "Hello, World!";
    }
}
