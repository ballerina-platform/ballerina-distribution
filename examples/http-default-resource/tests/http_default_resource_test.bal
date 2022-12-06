import ballerina/http;
import ballerina/test;

@test:Config {}
function testFunc() returns error? {
    http:Client httpEndpoint = check new("localhost:9090");
    string response = check httpEndpoint->get("/foo/bar");
    test:assertEquals(response, "method: GET, path: [\"foo\",\"bar\"]");
}
