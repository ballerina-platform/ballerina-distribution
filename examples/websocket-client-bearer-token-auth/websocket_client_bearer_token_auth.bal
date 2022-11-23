import ballerina/io;
import ballerina/websocket;

public function main() returns error? {
    // Defines the WebSocket client to call the secured APIs.
    // The client is enriched with the `Authorization: Bearer <token>` header by
    // passing the `websocket:BearerTokenConfig` for the `auth` configuration of the client.
    websocket:Client securedEP = check new("wss://localhost:9090/foo/bar",
        auth = {
            token: "56ede317-4511-44b4-8579-a08f094ee8c5"
        },
        secureSocket = {
            cert: "../resource/path/to/public.crt"
        }
    );
    check securedEP->writeMessage("Hello, World!");
    string textMessage = check securedEP->readMessage();
    io:println(textMessage);
}
