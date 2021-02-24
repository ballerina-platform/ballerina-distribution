import ballerina/http;
import ballerina/log;

// Defines the HTTP client to call the JWT auth secured APIs.
// The client is enriched with the `Authorization: Bearer <token>` header by
// passing the `http:JwtIssuerConfig` for the `auth` configuration of the
// client. A self-signed JWT is issued before the request is sent.
http:Client securedEP = check new("https://localhost:9090", {
    auth: {
        username: "wso2",
        issuer: "ballerina",
        audience: ["ballerina", "ballerina.org", "ballerina.io"],
        keyId: "5a0b754-895f-4279-8843-b745e11a57e9",
        customClaims: { "scp": "hello" },
        expTimeInSeconds: 3600,
        signatureConfig: {
            config: {
                keyAlias: "ballerina",
                keyPassword: "ballerina",
                keyStore: {
                    path: "../resources/ballerinaKeystore.p12",
                    password: "ballerina"
                }
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
