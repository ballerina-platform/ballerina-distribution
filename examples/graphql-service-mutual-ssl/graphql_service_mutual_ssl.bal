import ballerina/graphql;
import ballerina/http;

// An GraphQL listener can be configured to accept new connections that are
// secured via mutual SSL.
// The `graphql:ListenerSecureSocket` record provides the SSL-related listener configurations.
// For details, see https://lib.ballerina.io/ballerina/graphql/latest/records/ListenerSecureSocket.
listener graphql:Listener securedEP = new (9090,
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

service /graphql on securedEP {
    resource function get greeting() returns string {
        return "Hello, World!";
    }
}
