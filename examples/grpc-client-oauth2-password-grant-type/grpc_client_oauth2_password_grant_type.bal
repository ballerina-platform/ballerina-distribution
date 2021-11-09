import ballerina/io;

// Defines the gRPC client to call the OAuth2 secured APIs.
// The client metadata is enriched with the `Authorization: Bearer <token>`
// header by passing the [`grpc:OAuth2PasswordGrantConfig`](https://docs.central.ballerina.io/ballerina/grpc/latest/records/OAuth2PasswordGrantConfig) to the `auth`
// configuration of the client.
HelloWorldClient securedEP = check new("https://localhost:9090",
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

public function main() returns error? {
    string result = check securedEP->hello();
    io:println(result);
}
