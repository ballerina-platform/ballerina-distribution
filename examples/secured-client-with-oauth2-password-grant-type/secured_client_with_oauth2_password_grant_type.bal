import ballerina/http;
import ballerina/log;

// Defines the HTTP client to call the OAuth2 password grant type
// secured APIs.
// The client is enriched with `Authorization` header by passing the
// record of password grant configurations for `auth` configuration
// of the client.
http:Client securedEP = checkpanic new("https://localhost:9090", {
    auth: {
        tokenUrl: "https://localhost:9090/oauth2/token",
        username: "admin",
        password: "123",
        clientId: "s6BhdRkqt3",
        clientSecret: "7Fjfp0ZBr1KtDRbnfVdmIw",
        scopes: ["hello"],
        refreshConfig: {
            refreshUrl: "https://localhost:9090/oauth2/token/refresh",
            scopes: ["hello"],
            clientConfig: {
                secureSocket: {
                    trustStore: {
                        path: "../resources/ballerinaTruststore.p12",
                        password: "ballerina"
                    }
                }
            }
        },
        clientConfig: {
            secureSocket: {
                trustStore: {
                    path: "../resources/ballerinaTruststore.p12",
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
