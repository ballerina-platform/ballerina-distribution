import ballerina/io;

public function main() returns error? {
    // Defines the gRPC client to call the OAuth2-secured APIs.
    HelloWorldClient securedEP = check new("https://localhost:9090",
        auth = {
            refreshUrl: "https://localhost:9445/oauth2/token",
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

    string result = check securedEP->hello("WSO2");
    io:println(result);
}
