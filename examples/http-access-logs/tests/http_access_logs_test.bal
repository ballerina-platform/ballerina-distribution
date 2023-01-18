import ballerina/http;
import ballerina/test;

@test:Config {}
function testFunc() returns error? {
    http:Client httpEndpoint = check new("localhost:9095");
    string payload = check httpEndpoint->get("/accesslog");
    test:assertEquals(payload, "Successful");
}
