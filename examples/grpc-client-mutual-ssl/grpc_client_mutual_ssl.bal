import ballerina/grpc;
import ballerina/io;

// A gRPC client can be configured to initiate new connections that are
// secured via mutual SSL.
// The [`grpc:ClientSecureSocket`](https://docs.central.ballerina.io/ballerina/grpc/latest/records/ClientSecureSocket) record provides the SSL-related configurations.
HelloWorldClient securedEP = check new("https://localhost:9090",
    secureSocket = {
        key: {
            certFile: "../resource/path/to/public.crt",
            keyFile: "../resource/path/to/private.key"
        },
        cert: "../resource/path/to/public.crt",
        protocol: {
            name: grpc:TLS
        },
        ciphers: ["TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA"]

    }
);

public function main() returns error? {
    string result = check securedEP->hello();
    io:println(result);
}
