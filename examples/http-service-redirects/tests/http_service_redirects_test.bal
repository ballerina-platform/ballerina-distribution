import ballerina/test;
import ballerina/http;

@test:Config {}
function testFunc() returns error? {
    // Invoking the main function
    http:Client httpEndpoint = check new("localhost:9090",
            followRedirects = { enabled: true, maxCount: 5 });

    string expected = "Hello World!";

    // Send a GET request to the specified endpoint
    string response = check httpEndpoint->get("/redirect");
    test:assertEquals(response, expected);
}
