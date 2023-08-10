import ballerina/io;

public function main() returns error? {
    // The gRPC client can be configured to initiate new connections that are secured via mutual SSL.
    HelloWorldClient securedEP = check new("https://localhost:9090",
        secureSocket = {
            key: {
                certFile: "../resource/path/to/public.crt",
                keyFile: "../resource/path/to/private.key"
            },
            cert: "../resource/path/to/public.crt"
        }
    );

    string result = check securedEP->hello("WSO2");
    io:println(result);
}
