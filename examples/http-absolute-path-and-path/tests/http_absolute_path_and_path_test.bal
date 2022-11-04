import ballerina/test;
import ballerina/http;

@test:Config {}
function testFunc() returns error? {
    http:Client httpEndpoint = check new("http://localhost:9090");
    string payload = check httpEndpoint->get("/info/student");
    test:assertEquals(payload, "Student data");
}
