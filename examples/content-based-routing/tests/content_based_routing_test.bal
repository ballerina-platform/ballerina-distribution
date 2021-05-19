import ballerina/http;
import ballerina/test;

@test:Config {}
function testFunc() returns @tainted error? {
    // Invoking the main function
    http:Client httpEndpoint = checkpanic new("http://localhost:9090");
    json payload = { name: "sanFrancisco" };
    json payload2 = { name: "london" };

    json response1 = {
        name: "San Francisco Test Station,USA",
        longitude: -122.43,
        latitude: 37.76,
        altitude: 150,
        rank: 1
    };

    json response2 = {
        name: "London Test Station,England",
        longitude: -156.49,
        latitude: 57.76,
        altitude: 430,
        rank: 5
    };

    http:Request req = new;
    req.setJsonPayload(payload);
    // Send a GET request to the specified endpoint
    json response = check httpEndpoint->post("/cbr/route", req);
    test:assertEquals(response.toJsonString(), response1.toJsonString());

    http:Request req2 = new;
    req2.setJsonPayload(payload2);
    // Send a GET request to the specified endpoint
    json respnc = httpEndpoint->post("/cbr/route", req2);
    test:assertEquals(respnc.toJsonString(), response2.toJsonString());
    return;
}
