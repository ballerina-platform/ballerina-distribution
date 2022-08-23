import ballerina/io;
import ballerina/websocket;

// Defines the WebSocket client to call the Basic Auth secured APIs.
// The client is enriched with the `Authorization: Basic <token>` header by
// passing the `websocket:CredentialsConfig` for the `auth` configuration of the client.
// FOr details, see https://lib.ballerina.io/ballerina/websocket/latest/records/CredentialsConfig.
websocket:Client securedEP = check new("wss://localhost:9090/foo/bar",
    auth = {
        username: "ldclakmal",
        password: "ldclakmal@123"
    },
    secureSocket = {
        cert: "../resource/path/to/public.crt"
    }
);

public function main() returns error? {
    check securedEP->writeMessage("Hello, World!");
    string textMessage = check securedEP->readMessage();
    io:println(textMessage);
}
