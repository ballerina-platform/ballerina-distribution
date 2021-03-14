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
    var response = httpEndpoint->get("/hbr/route", {"x-type": "location"});
    if (response is http:Response) {
        var realResponse = check response.getJsonPayload();
        test:assertEquals(realResponse.toJsonString(), expectedJson.toJsonString());
    } else {
        test:assertFail(msg = "Failed to call the endpoint:");
    }
    return;
}
