import ballerina/config;
import ballerina/http;
import ballerina/jwt;
import ballerina/test;

@test:Config {}
function testFunc() {
    jwt:OutboundJwtAuthProvider outboundJwtAuthProvider = new({
        username: "admin",
        issuer: "ballerina",
        audience: ["vEwzbcasJVQm1jVYHUHCjhxZ4tYa"],
        customClaims: { "scope": "hello" },
        keyStoreConfig: {
            keyAlias: "ballerina",
            keyPassword: "ballerina",
            keyStore: {
                path: config:getAsString("b7a.home") +
                      "/bre/security/ballerinaKeystore.p12",
                password: "ballerina"
            }
        }
    });
    http:BearerAuthHandler outboundJwtAuthHandler = new(outboundJwtAuthProvider);
    http:Client httpEndpoint = new("https://localhost:9090", {
        auth: {
            authHandler: outboundJwtAuthHandler
        },
        secureSocket: {
            trustStore: {
                path: config:getAsString("b7a.home") +
                      "/bre/security/ballerinaTruststore.p12",
                password: "ballerina"
            }
        }
    });

    var response = httpEndpoint->get("/hello/sayHello");
    if (response is http:Response) {
        test:assertEquals(response.getTextPayload(), "Hello, World!!!");
    } else {
        test:assertFail(msg = "Failed to call the endpoint:");
    }
}
