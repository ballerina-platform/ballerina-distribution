import ballerina/io;
import ballerina/websocket;

// Defines the WebSocket client to call the Basic authentication secured APIs.
// The client is enriched with the `Authorization: Basic <token>` header by
// passing the `websocket:CredentialsConfig` for the `auth` configuration of the client.
websocket:Client securedEP = check new("wss://localhost:9090/chat",
    auth = {
        username: "ldclakmal",
        password: "ldclakmal@123"
    },
    secureSocket = {
        cert: "../resource/path/to/public.crt"
    }
);

public function main() returns error? {
    check securedEP->writeMessage("Hello, John!");
    string chatMessage = check securedEP->readMessage();
    io:println(chatMessage);
}
