import ballerina/grpc;

// A gRPC listener can be configured to accept new connections that are
// secured via mutual SSL.
// The [`grpc:ListenerSecureSocket` record provides the SSL-related listener configurations.
// For details, see https://lib.ballerina.io/ballerina/grpc/latest/records/ListenerSecureSocket.
listener grpc:Listener securedEP = new(9090,
    secureSocket = {
        key: {
            certFile: "../resource/path/to/public.crt",
            keyFile: "../resource/path/to/private.key"
        },
        // Enables mutual SSL.
        mutualSsl: {
            verifyClient: grpc:REQUIRE,
            cert: "../resource/path/to/public.crt"
        },
        // Enables the preferred SSL protocol and its versions.
        protocol: {
            name: grpc:TLS,
            versions: ["TLSv1.2", "TLSv1.1"]
        },
        // Configures the preferred ciphers.
        ciphers: ["TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA"]

    }
);

@grpc:Descriptor {
    value: GRPC_SIMPLE_DESC
}
service "HelloWorld" on securedEP {
    remote function hello(string request) returns string|error {
        return "Hello " + request;
    }
}
