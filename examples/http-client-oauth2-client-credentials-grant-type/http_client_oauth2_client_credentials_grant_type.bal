import ballerina/http;
import ballerina/io;

type Album readonly & record {|
    string title;
    string artist;
|};

public function main() returns error? {
    // Defines the HTTP client to call the OAuth2 secured APIs.
    // The client is enriched with the `Authorization: Bearer <token>` header by
    // passing the `http:OAuth2ClientCredentialsGrantConfig` for the `auth` configuration of the client.
    http:Client securedEP = check new("localhost:9090",
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
    Album[] payload = check securedEP->/albums;
    io:println(payload);
}
