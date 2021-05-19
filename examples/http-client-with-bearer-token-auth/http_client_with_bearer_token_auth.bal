import ballerina/http;
import ballerina/log;

// Defines the HTTP client to call the secured APIs.
// The client is enriched with the `Authorization: Bearer <token>` header by
// passing the `http:BearerTokenConfig` for the `auth` configuration of the
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
    // Sends a `GET` request to the specified endpoint.
    http:Response response = check securedEP->get("/foo/bar");
    log:printInfo(response.statusCode.toString());
}
