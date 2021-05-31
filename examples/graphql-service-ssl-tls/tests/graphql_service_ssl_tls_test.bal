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
    http:Response response = check clientEP->post("/graphql", payload, "application/json");
    io:println((check response.getJsonPayload()).toString());
}
