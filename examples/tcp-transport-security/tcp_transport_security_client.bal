import ballerina/io;
import ballerina/tcp;

// An TCP client can be configured to communicate through SSL/TLS as well.
// To secure a client using SSL/TLS, the client needs to be configured with
// a certificate file of the listener.
// The [`tcp:ClientSecureSocket`](https://docs.central.ballerina.io/ballerina/tcp/latest/records/ClientSecureSocket) record
// provides the SSL-related configurations of the client.
tcp:Client securedClientEP = check new("localhost", 3000,
    secureSocket = {
        cert: "../resource/path/to/public.crt"
    }
);

public function main() returns error? {
    check securedClientEP->writeBytes("Hello, World!".toBytes());
    readonly & byte[] receivedData = check securedClientEP->readBytes();
    io:println("Received message: ", string:fromBytes(receivedData));
    return securedClientEP->close();
}
