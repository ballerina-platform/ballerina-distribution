import ballerina/test;
import ballerina/http;

@test:Config {}
function testFunc() returns error? {
    http:Client httpEndpoint = check new("http://localhost:9090");
    string response = check httpEndpoint->get("/hello", {"X-Client-Key": "0987654321"});
    test:assertEquals(response, "0987654321");
}
