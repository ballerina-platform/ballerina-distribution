import ballerina/io;
import ballerina/websocket;

public function main() returns error? {
    // Defines the WebSocket client to call the Basic auth secured APIs.
    // The client is enriched with the `Authorization: Basic <token>` header by
    // passing the `websocket:CredentialsConfig` for the `auth` configuration of the
    // client.
    websocket:Client securedEP = check new("wss://localhost:9090/wss",
        auth = {
            username: "User1",
            password: "p@ssw0rd"
        },
        secureSocket = {
            cert: "../resource/path/to/public.crt"
        }
    );
    check securedEP->writeTextMessage("Hello, World");
    string textMessage = check securedEP->readTextMessage();
    io:println(textMessage);
}
