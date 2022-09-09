import ballerina/io;

// A gRPC client can be configured to communicate through SSL/TLS as well.
// To secure a client using SSL/TLS, the client needs to be configured with
// a certificate file of the listener.
// The `grpc:ClientSecureSocket` record provides the SSL-related configurations of the client.
// For details, see https://lib.ballerina.io/ballerina/grpc/latest/records/ClientSecureSocket.
HelloWorldClient securedEP = check new("https://localhost:9090",
    secureSocket = {
        cert: "../resource/path/to/public.crt"
    }
);

public function main() returns error? {
    string result = check securedEP->hello();
    io:println(result);
}
