import ballerina/io;
import ballerina/websocket;

public function main() returns error? {
    // Defines the WebSocket client to call the OAuth2 secured APIs.
    // The client is enriched with the `Authorization: Bearer <token>` header by
    // passing the `websocket:RefreshTokenGrantConfig` for the `auth` configuration of the
    // client.
    websocket:Client securedEP = check new("wss://localhost:9090/wss",
        auth = {
            refreshUrl: "https://localhost:9401/oauth2/token",
            refreshToken: "24f19603-8565-4b5f-a036-88a945e1f272",
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

    check securedEP->writeTextMessage("Hello, World");
    string textMessage = check securedEP->readTextMessage();
    io:println(textMessage);
}
