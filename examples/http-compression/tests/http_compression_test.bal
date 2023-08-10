import ballerina/http;
import ballerina/test;

@test:Config {}
function testFunc() returns error? {
    http:Client httpEndpoint = check new("localhost:9090");
    // Send a GET request to the specified endpoint.
    string response = check httpEndpoint->get("/compress");
    // Assert the uncompressed response.
    test:assertEquals(response, "Type : This is a string.");
}
