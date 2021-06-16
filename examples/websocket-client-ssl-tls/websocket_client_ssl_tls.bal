import ballerina/websocket;
import ballerina/io;

// A WebSocket client can be configured to communicate through WSS as well.
// To secure a client using TLS/SSL, the client needs to be configured with
// a certificate file of the listener.
// The [`websocket:ClientSecureSocket`](https://docs.central.ballerina.io/ballerina/websocket/latest/records/ClientSecureSocket) record
// provides the SSL-related configurations of the client.
websocket:Client securedEP = check new("wss://localhost:9090/foo/bar",
    secureSocket = {
        cert: "../resource/path/to/public.crt"
    }
);

public function main() returns error? {
    check securedEP->writeTextMessage("Hello, World!");
    string textMessage = check securedEP->readTextMessage();
    io:println(textMessage);
}
