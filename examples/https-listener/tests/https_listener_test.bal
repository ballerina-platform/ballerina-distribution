import ballerina/http;
import ballerina/test;

http:Client clientEP = check new("https://localhost:9090",
    secureSocket = {
        cert: "../resource/path/to/public.crt"
    }
);

@test:Config {}
function testFunc() {
    http:Response|error response = clientEP->get("/foo/bar");
    if (response is http:Response) {
        test:assertEquals(response.getTextPayload(), "Hello, World!");
    } else {
        test:assertFail(msg = "Failed to call the endpoint.");
    }
}
