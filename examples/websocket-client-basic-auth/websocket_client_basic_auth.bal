import ballerina/io;
import ballerina/websocket;

// Defines the WebSocket client to call the Basic auth secured APIs.
// The client is enriched with the `Authorization: Basic <token>` header by
// passing the [`websocket:CredentialsConfig`](https://docs.central.ballerina.io/ballerina/websocket/latest/records/CredentialsConfig) for the `auth` configuration of the
// client.
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
    check securedEP->writeTextMessage("Hello, World!");
    string textMessage = check securedEP->readTextMessage();
    io:println(textMessage);
}
