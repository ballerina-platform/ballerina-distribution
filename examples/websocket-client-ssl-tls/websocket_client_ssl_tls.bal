import ballerina/websocket;
import ballerina/io;

public function main() returns error? {
    // A WebSocket client can be configured to communicate through WSS as well.
    // To secure a client using TLS/SSL, the client needs to be configured with
    // a certificate file of the listener.
    // The `websocket:ClientSecureSocket` record provides the SSL-related configurations of the client.
    websocket:Client securedEP = check new("wss://localhost:9090/chat",
        secureSocket = {
            cert: "../resource/path/to/public.crt"
        }
    );
    check securedEP->writeMessage("Hello, John!");
    string chatMessage = check securedEP->readMessage();
    io:println(chatMessage);
}
