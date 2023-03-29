import ballerina/io;
import ballerina/websocket;

public function main() returns error? {
    // Defines the WebSocket client to call the OAuth2 secured APIs.
    // The client is enriched with the `Authorization: Bearer <token>` header by
    // passing the `websocket:OAuth2JwtBearerGrantConfig` for the `auth` configuration of the client.
    websocket:Client chatClient = check new ("wss://localhost:9090/foo/bar",
        auth = {
            tokenUrl: "https://localhost:9445/chat",
            assertion: "eyJhbGciOiJFUzI1NiIsImtpZCI6Ij[...omitted for brevity...]",
            clientId: "FlfJYKBD2c925h4lkycqNZlC2l4a",
            clientSecret: "PJz0UhTJMrHOo68QQNpvnqAY_3Aa",
            scopes: ["admin"],
            clientConfig: {
                secureSocket: {
                    cert: "../resource/path/to/public.crt"
                }
            }
        },
        secureSocket = {
            cert: "../resource/path/to/public.crt"
        }
    );
    check chatClient->writeMessage("Hello, John!");
    string chatMessage = check chatClient->readMessage();
    io:println(chatMessage);
}
