import ballerina/http;
import ballerina/test;

@test:Config {}
function testFunc() returns error? {
    // Invoking the main function
    http:Client httpEndpoint = check new("localhost:9090");
    string response1 = "Hello World!\n";

    // Send a GET request to the specified endpoint
    string response = check httpEndpoint->post("/greeting", "Hello from client");
    test:assertEquals(response, response1);
}

