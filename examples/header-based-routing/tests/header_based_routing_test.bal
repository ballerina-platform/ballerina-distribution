import ballerina/http;
import ballerina/test;

@test:Config {}
function testFunc() returns @tainted error? {
    // Invoking the main function.
    http:Client httpEndpoint = checkpanic new("http://localhost:9090");
    json expectedJson = {
        name: "Colombo,Sri Lanka",
        longitude: -556.49,
        latitude: 257.76,
        altitude: 230
    };

    // Send a GET request to the specified endpoint.
    json realResponse = check httpEndpoint->get("/hbr/route", {"x-type": "location"});
    test:assertEquals(realResponse.toJsonString(), expectedJson.toJsonString());
}
