import ballerina/http;
import ballerina/io;

// Defines the HTTP client to call the OAuth2 secured APIs.
// The client is enriched with the `Authorization: Bearer <token>` header by
// passing the [`http:OAuth2ClientCredentialsGrantConfig`](https://docs.central.ballerina.io/ballerina/http/latest/records/OAuth2ClientCredentialsGrantConfig) for the `auth` configuration
// of the client.
http:Client securedEP = check new("https://localhost:9090",
    auth = {
        tokenUrl: "https://localhost:9445/oauth2/token",
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

public function main() returns error? {
    string response = check securedEP->get("/foo/bar");
    io:println(response);
}
