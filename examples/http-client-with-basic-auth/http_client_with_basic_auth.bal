import ballerina/http;
import ballerina/log;

// Defines the HTTP client to call the Basic auth secured APIs.
// The client is enriched with the `Authorization: Basic <token>` header by
// passing the `http:CredentialsConfig` for the `auth` configuration of the
// client.
http:Client securedEP = check new("https://localhost:9090",
    auth = {
        username: "ldclakmal",
        password: "ldclakmal@123"
    },
    secureSocket = {
        cert: "../resource/path/to/public.crt"
    }
);

public function main() {
    // Send a `GET` request to the specified endpoint.
    http:Response|http:ClientError response = securedEP->get("/foo/bar");
    if (response is http:Response) {
        log:printInfo(response.statusCode.toString());
    } else {
        log:printError("Failed to call the endpoint.", 'error = response);
    }
}
