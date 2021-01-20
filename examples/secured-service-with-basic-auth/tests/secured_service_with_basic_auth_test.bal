import ballerina/auth;
import ballerina/config;
import ballerina/http;
import ballerina/test;

@test:Config {}
function testFunc() {
    auth:OutboundBasicAuthProvider outboundBasicAuthProvider = new({ username: "bob", password: "password2" });
    http:BasicAuthHandler outboundBasicAuthHandler = new(outboundBasicAuthProvider);
    http:Client httpEndpoint = new("https://localhost:9090", {
        auth: {
            authHandler: outboundBasicAuthHandler
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
