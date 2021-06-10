import ballerina/http;
import ballerina/test;

http:Client clientEP = check new("https://localhost:9090",
    secureSocket = {
        cert: "../resource/path/to/public.crt"
    }
);

@test:Config {}
function testFunc() returns error? {
    json payload = { "query": "{ greeting }" };
    json actualResponse = check clientEP->post("/graphql", payload);
    json expectedResponse = {
        data: {
            greeting: "Hello, World!"
        }
    };
    test:assertEquals(actualResponse, expectedResponse);
}
