import ballerina/io;
import ballerina/websocket;

public function main() returns error? {
    // Defines the WebSocket client to call the Basic authentication secured APIs.
    // The client is enriched with the `Authorization: Basic <token>` header by
    // passing the `websocket:CredentialsConfig` for the `auth` configuration of the client.
    websocket:Client chatClient = check new("wss://localhost:9090/chat",
        auth = {
            username: "ldclakmal",
            password: "ldclakmal@123"
        },
        secureSocket = {
            cert: "../resource/path/to/public.crt"
        }
    );
    check chatClient->writeMessage("Hello, John!");
    string chatMessage = check chatClient->readMessage();
    io:println(chatMessage);
}
