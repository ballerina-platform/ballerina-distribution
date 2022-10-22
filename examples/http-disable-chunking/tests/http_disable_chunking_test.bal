import ballerina/http;
import ballerina/test;

@test:Config {}
function testFunc() returns error? {
    http:Client httpEndpoint = check new("http://localhost:9092");
    string response = check httpEndpoint->get("/chunk");
    test:assertEquals(response, "Outbound request content length: 20");
}
