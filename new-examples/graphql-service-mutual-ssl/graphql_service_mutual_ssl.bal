import ballerina/graphql;
import ballerina/http;

// An GraphQL listener can be configured to accept new connections that are
// secured via mutual SSL.
// The [`graphql:ListenerSecureSocket`](https://docs.central.ballerina.io/ballerina/graphql/latest/records/ListenerSecureSocket) record provides the SSL-related listener configurations.
listener graphql:Listener securedEP = new(9090,
    secureSocket = {
        key: {
            certFile: "../resource/path/to/public.crt",
            keyFile: "../resource/path/to/private.key"
        },
        // Enables mutual SSL.
        mutualSsl: {
            verifyClient: http:REQUIRE,
            cert: "../resource/path/to/public.crt"
        },
        // Enables the preferred SSL protocol and its versions.
        protocol: {
            name: http:TLS,
            versions: ["TLSv1.2", "TLSv1.1"]
        },
        // Configures the preferred ciphers.
        ciphers: ["TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA"]

    }
);

service /graphql on securedEP {
    resource function get greeting() returns string {
        return "Hello, World!";
    }
}
