import ballerina/http;
import ballerina/io;

// Defines the HTTP client to call the secured APIs.
// The client is enriched with the `Authorization: Bearer <token>` header by
// passing the [`http:BearerTokenConfig`](https://docs.central.ballerina.io/ballerina/http/latest/records/BearerTokenConfig) for the `auth` configuration of the
// client.
http:Client securedEP = check new("https://localhost:9090",
    auth = {
        token: "56ede317-4511-44b4-8579-a08f094ee8c5"
    },
    secureSocket = {
        cert: "../resource/path/to/public.crt"
    }
);

public function main() returns error? {
    string response = check securedEP->get("/foo/bar");
    io:println(response);
}
