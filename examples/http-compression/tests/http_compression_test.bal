import ballerina/http;
import ballerina/test;

@test:Config {}
function testFunc() returns error? {
    http:Client httpEndpoint = check new("http://localhost:9090");

    string expectedJson = "Type : This is a string";
    // Send a GET request to the specified endpoint
    http:Response|error response = httpEndpoint->get("/alwaysCompress");
    // Assert the uncompressed response
    if (response is http:Response) {
        string actualPayload = check response.getTextPayload();
        test:assertEquals(actualPayload, expectedJson);
    } else {
        test:assertFail(msg = "Failed to call the endpoint:");
    }
}
