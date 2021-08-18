import ballerina/grpc;

// A gRPC listener can be configured to accept new connections that are
// secured via mutual SSL.
// The [`grpc:ListenerSecureSocket`](https://docs.central.ballerina.io/ballerina/grpc/latest/records/ListenerSecureSocket) record provides the SSL-related listener configurations.
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

@grpc:ServiceDescriptor {
    descriptor: ROOT_DESCRIPTOR_GRPC_SERVICE,
    descMap: getDescriptorMapGrpcService()
}
service "HelloWorld" on securedEP {
    remote function hello() returns string {
        return "Hello, World!";
    }
}
