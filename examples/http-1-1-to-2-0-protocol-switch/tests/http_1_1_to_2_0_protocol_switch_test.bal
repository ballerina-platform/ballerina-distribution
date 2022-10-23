import ballerina/test;
import ballerina/http;

@test:Config {}
function testFunc() returns error? {
    http:Client httpEndpoint = check new("http://localhost:9090");
    string response = check httpEndpoint->get("/http11service");
    test:assertEquals(response, "message : response from http2 service");
}
