import ballerina/test;
import ballerina/http;

@test:Config {}
function testFunc() returns @tainted error? {
    // Invoking the main function.
    http:Client httpEndpoint = checkpanic new("http://localhost:9090");

    // Send a `POST` request to the specified endpoint.
    json payload = { "hello": "world" };
    json jsonRes = check httpEndpoint->post("/foo/bar", payload);
    test:assertEquals(jsonRes, payload);
    return;
}
