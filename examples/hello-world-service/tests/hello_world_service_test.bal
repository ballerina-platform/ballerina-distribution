import ballerina/test;
import ballerina/http;

boolean serviceStarted = false;

function startService() {
    //serviceStarted = test:startServices("hello-world-service");
}

@test:Config {
    before: startService,
    after: stopService
}
function testFunc() {
    // Invoking the main function
    http:Client httpEndpoint = checkpanic new("http://localhost:9090");
    // Check whether the server is started
    //test:assertTrue(serviceStarted, msg = "Unable to start the service");

    string response1 = "Hello, World!";

    // Send a GET request to the specified endpoint
    string response = check httpEndpoint->get("/greeting");
    test:assertEquals(response, response1);
}

function stopService() {
    //test:stopServices("hello-world-service");
}