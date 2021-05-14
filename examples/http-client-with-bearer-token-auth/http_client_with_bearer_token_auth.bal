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

public function main() {
    // Sends a `GET` request to the specified endpoint.
    http:Response|http:ClientError response = securedEP->get("/foo/bar");
    if response is http:Response {
        log:printInfo(response.statusCode.toString());
    } else {
        log:printError("Failed to call the endpoint.", 'error = response);
    }
}
