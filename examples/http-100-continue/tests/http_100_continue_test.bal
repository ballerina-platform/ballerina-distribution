import ballerina/test;
import ballerina/http;

boolean serviceStarted = false;

function startService() {
    //serviceStarted = test:startServices("http-100-continue");
}

@test:Config {
    before: startService,
    after: stopService
}
function testFunc() returns error? {
    // Invoking the main function
    http:Client httpEndpoint = checkpanic new("http://localhost:9090");
    // Check whether the server is started
    //test:assertTrue(serviceStarted, msg = "Unable to start the service");

    string response1 = "Hello World!\n";

    // Send a GET request to the specified endpoint
    string response = check httpEndpoint->post("/hello", "Hello from client");
    test:assertEquals(response, response1);
}

function stopService() {
    //test:stopServices("http-100-continue");
}