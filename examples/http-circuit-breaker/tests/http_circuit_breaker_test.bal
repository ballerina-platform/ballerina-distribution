import ballerina/test;
import ballerina/io;
import ballerina/http;

@test:Config {}
function testFunc() {
    // Invoking the main function.
    http:Client httpEndpoint = checkpanic new("http://localhost:9090");

    string responseString = "Hello World!!!";
    // Send a GET request to the specified endpoint
    http:Response|error response1 = httpEndpoint->get("/cb");
    if (response1 is http:Response) {
        var result = response1.getTextPayload();
        if (result is string) {
            test:assertEquals(result, responseString);
        } else {
            test:assertFail(msg = "Invalid response message:");
        }
    } else {
        test:assertFail(msg = "Failed to call the endpoint:");
    }

    // Send a GET request to the specified endpoint.
    http:Response|error response2 = httpEndpoint->get("/cb");
    if (response2 is http:Response) {
        var result = response2.getTextPayload();
        if (result is string) {
            test:assertEquals(result, responseString);
        } else {
            test:assertFail(msg = "Invalid response message:");
        }
    } else {
        test:assertFail(msg = "Failed to call the endpoint:");
    }

    // Send a GET request to the specified endpoint.
    http:Response|error response3 = httpEndpoint->get("/cb");
    if (response3 is http:Response) {
        var result = response3.getTextPayload();
        if (result is string) {
            test:assertEquals(result, "Error occurred while processing the request.");
        } else {
            test:assertFail(msg = "Invalid response message:");
        }
    } else {
        test:assertFail(msg = "Failed to call the endpoint:");
    }

    // Send a GET request to the specified endpoint.
    http:Response|error response4 = httpEndpoint->get("/cb");
    if (response4 is http:Response) {
        string|error result = response4.getTextPayload();
        test:assertTrue(result is string,  "Invalid return type");
    } else {
        test:assertFail(msg = "Failed to call the endpoint:");
    }

    // Send a GET request to the specified endpoint.
    http:Response|error response5 = httpEndpoint->get("/cb");
    if (response5 is http:Response) {
        string|error result = response5.getTextPayload();
        test:assertTrue(result is string,  "Invalid return type");
    } else {
        test:assertFail(msg = "Failed to call the endpoint:");
    }

    io:println("Reached");

    // Send a GET request to the specified endpoint.
    http:Response|error response6 = httpEndpoint->get("/cb");
    if (response6 is http:Response) {
        string|error result = response6.getTextPayload();
        test:assertTrue(result is string,  "Invalid return type");
    } else {
        test:assertFail(msg = "Failed to call the endpoint:");
    }
}
