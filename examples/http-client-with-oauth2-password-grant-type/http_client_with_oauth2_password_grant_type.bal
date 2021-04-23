import ballerina/http;
import ballerina/log;

// Defines the HTTP client to call the OAuth2 secured APIs.
// The client is enriched with the `Authorization: Bearer <token>` header by
// passing the `http:PasswordGrantConfig` to the `auth` configuration of the
// client.
http:Client securedEP = check new("https://localhost:9090", {
    auth: {
        tokenUrl: "https://localhost:9443/oauth2/token",
        username: "admin",
        password: "123",
        clientId: "FlfJYKBD2c925h4lkycqNZlC2l4a",
        clientSecret: "PJz0UhTJMrHOo68QQNpvnqAY3Aa",
        scopes: ["hello"],
        refreshConfig: {
            refreshUrl: "https://localhost:9443/oauth2/token/refresh",
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
    secureSocket: {
        cert: "../resource/path/to/public.crt"
    }
});

public function main() {
    // Send a `GET` request to the specified endpoint.
    http:Response|http:ClientError response = securedEP->get("/foo/bar");
    if (response is http:Response) {
        log:printInfo(response.statusCode.toString());
    } else {
        log:printError("Failed to call the endpoint.", 'error = response);
    }
}
