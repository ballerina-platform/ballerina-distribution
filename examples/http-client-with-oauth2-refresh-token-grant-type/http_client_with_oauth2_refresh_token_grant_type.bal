import ballerina/http;
import ballerina/log;

// Defines the HTTP client to call the OAuth2 secured APIs.
// The client is enriched with the `Authorization: Bearer <token>` header by
// passing the `http:RefreshTokenGrantConfig` for the `auth` configuration of the
// client.
http:Client securedEP = check new("https://localhost:9090", {
    auth: {
        refreshUrl: "https://localhost:9443/oauth2/token/refresh",
        refreshToken: "tGzv3JOkFNp0AaXG5QrHOo68Qx2TlKz0UWIA",
        clientId: "FlfJYKBD2c925h4lkycqNZlC2l4a",
        clientSecret: "PJz0UhTJMrHOo68QQNpvnqAY_3Aa",
        scopes: ["hello"],
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
