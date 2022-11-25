import ballerina/io;
import ballerina/websocket;

public function main() returns error? {
    // Defines the WebSocket client to call the Basic authentication secured APIs.
    // The client is enriched with the `Authorization: Basic <token>` header by
    // passing the `websocket:CredentialsConfig` for the `auth` configuration of the client.
    websocket:Client securedEP = check new("wss://localhost:9090/foo/bar",
        auth = {
            username: "ldclakmal",
            password: "ldclakmal@123"
        },
        secureSocket = {
            cert: "../resource/path/to/public.crt"
        }
    );
    check securedEP->writeMessage("Hello, World!");
    string textMessage = check securedEP->readMessage();
    io:println(textMessage);
}
