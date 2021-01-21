import ballerina/http;
import ballerina/log;

// Defines the HTTP client to call the Basic auth secured APIs.
// The client is enriched with the `Authorization: Basic <token>` header by
// passing the `http:CredentialsConfig` for the `auth` configuration of the
// client.
http:Client securedEP = check new("https://localhost:9090", {
    auth: {
        username: "alice",
        password: "123"
    },
    secureSocket: {
        trustStore: {
            path: "../resources/ballerinaTruststore.p12",
            password: "ballerina"
        }
    }
});

public function main() {
    // Send a `GET` request to the specified endpoint.
    var response = securedEP->get("/foo/bar");
    if (response is http:Response) {
        log:print(response.statusCode.toString());
    } else if (response is http:ClientError) {
        log:printError("Failed to call the endpoint.", err = response);
    }
}
