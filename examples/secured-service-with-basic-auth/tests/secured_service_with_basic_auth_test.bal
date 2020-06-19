import ballerina/auth;
import ballerina/http;
import ballerina/test;

@test:Config {}
function testFunc() {
    auth:OutboundBasicAuthProvider outboundBasicAuthProvider = new({ username: "generalUser2", password: "password" });
    http:BasicAuthHandler outboundBasicAuthHandler = new(outboundBasicAuthProvider);
    http:Client httpEndpoint = new("https://localhost:9090", {
        auth: {
            authHandler: outboundBasicAuthHandler
        }
    });

    var response = httpEndpoint->get("/hello/sayHello");
    if (response is http:Response) {
        test:assertEquals(response.getTextPayload(), "Hello, World!!!");
    } else {
        test:assertFail(msg = "Failed to call the endpoint:");
    }
}
