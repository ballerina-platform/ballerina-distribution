import ballerina/http;
import ballerina/test;

@test:Config {}
function testFunc() returns error? {
    http:Client httpEndpoint = check new("http://localhost:9095");
    string payload = check httpEndpoint->get("/hello");
    test:assertEquals(payload, "Successful");
}
