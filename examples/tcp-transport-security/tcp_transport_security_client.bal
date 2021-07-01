import ballerina/io;
import ballerina/tcp;

// An TCP client can be configured to communicate through SSL/TLS as well.
// To secure a client using SSL/TLS, the client needs to be configured with
// a certificate file of the listener.
// The [`tcp:ClientSecureSocket`](https://docs.central.ballerina.io/ballerina/tcp/latest/records/ClientSecureSocket) record
// provides the SSL-related configurations of the client.
tcp:Client securedEP = check new ("localhost", 3000,
    secureSocket = {
        // Provide the trusted certificate path or the truststore path
        // along with the truststore password.
        cert: "../resource/path/to/public.crt",
        protocol: {
            name: tcp:TLS,
            versions: ["TLSv1.2", "TLSv1.1"]
        },
        ciphers: ["TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA"]
    }
);

public function main() returns error? {
    check securedEP->writeBytes("Hello, World!".toBytes());
    readonly & byte[] receivedData = check securedEP->readBytes();
    io:println("Received message: ", string:fromBytes(receivedData));
    check securedEP->close();
}
