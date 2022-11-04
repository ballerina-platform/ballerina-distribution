import ballerina/http;
import ballerina/test;

@test:Config {}
function testFunc() returns error? {
    http:Client httpEndpoint = check new("http://localhost:9090");
    string result = check httpEndpoint->get("/info?page=3");
    test:assertEquals(result, "Info on page 3");
}
