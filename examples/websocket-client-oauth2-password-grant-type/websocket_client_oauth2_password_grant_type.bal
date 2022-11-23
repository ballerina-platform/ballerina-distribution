import ballerina/io;
import ballerina/websocket;

public function main() returns error? {
    // Defines the WebSocket client to call the OAuth2 secured APIs.
    // The client is enriched with the `Authorization: Bearer <token>` header by
    // passing the `websocket:OAuth2PasswordGrantConfig` to the `auth` configuration of the client.
    websocket:Client securedEP = check new("wss://localhost:9090/foo/bar",
        auth = {
            tokenUrl: "https://localhost:9445/oauth2/token",
            username: "admin",
            password: "admin",
            clientId: "FlfJYKBD2c925h4lkycqNZlC2l4a",
            clientSecret: "PJz0UhTJMrHOo68QQNpvnqAY_3Aa",
            scopes: ["admin"],
            refreshConfig: {
                refreshUrl: "https://localhost:9445/oauth2/token",
                scopes: ["hello"],
                clientConfig: {
                    secureSocket: {
                        cert: "../resource/path/to/public.crt"
                    }
                }
            },
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
    check securedEP->writeMessage("Hello, World!");
    string textMessage = check securedEP->readMessage();
    io:println(textMessage);
}
