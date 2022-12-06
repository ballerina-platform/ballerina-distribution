import ballerina/test;
import ballerina/http;

@test:Config {}
function testFunc() returns error? {
    // Invoking the main function
    http:Client httpEndpoint = check new("localhost:9090",
            followRedirects = { enabled: true, maxCount: 5 });

    string expected = "Response received : Hello World!";

    // Send a GET request to the specified endpoint
    string response = check httpEndpoint->get("/greeting");
    test:assertEquals(response, expected);
}
