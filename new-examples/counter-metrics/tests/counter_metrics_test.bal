import ballerina/test;
import ballerina/io;
import ballerina/http;

@test:Config { }
function testFunc() returns error? {
    // Invoking the main function
    http:Client httpEndpoint = check new("http://localhost:9090");

    string response1 = "Order Processed!";

    // Send a GET request to the specified endpoint.
    string response = check httpEndpoint->get("/onlineStoreService/makeOrder");
    test:assertEquals(response, response1);
}
