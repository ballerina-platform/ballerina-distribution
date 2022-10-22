import ballerina/http;
import ballerina/test;

@test:Config {}
function testFunc() returns error? {
    http:Client httpEndpoint = check new("http://localhost:9090");
    int sum = check httpEndpoint->get("/sum?a=3&b=5");
    test:assertEquals(sum, 8);
}
