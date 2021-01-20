import ballerina/http;
import ballerina/log;

// Defines the HTTP client to call the JWT Auth secured APIs.
// The client is enriched with `Authorization` header by passing the
// record of JWT issuer configurations for `auth` configuration
// of the client. The signature of the JWT is a self signed signature
// at the time of issuing.
http:Client securedEP = checkpanic new("https://localhost:9090", {
    auth: {
        username: "admin",
        issuer: "ballerina",
        audience: ["ballerina", "ballerina.org", "ballerina.io"],
        keyId: "5a0b754-895f-4279-8843-b745e11a57e9",
        customClaims: { "scp": "hello" },
        expTimeInSeconds: 3600,
        keyStoreConfig: {
            keyAlias: "ballerina",
            keyPassword: "ballerina",
            keyStore: {
                path: "../resources/ballerinaKeystore.p12",
                password: "ballerina"
            }
        }
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
