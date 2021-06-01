import ballerina/test;
import ballerina/http;

@test:Config {}
function testFunc() returns error? {
    http:Client httpEndpoint = checkpanic new("http://localhost:9090");
    json payload = { "hello": "world" };
    json jsonRes = check httpEndpoint->post("/foo/bar", payload);
    test:assertEquals(jsonRes, payload);
}
