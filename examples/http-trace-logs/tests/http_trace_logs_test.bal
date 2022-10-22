import ballerina/http;
import ballerina/test;

@test:Config {}
function testFunc() returns error? {
    http:Client httpEndpoint = check new("http://localhost:9090");
    string res = check httpEndpoint->get("/trace");
    test:assertEquals(res, "200 OK");
}
