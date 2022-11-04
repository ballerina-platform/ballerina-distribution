import ballerina/http;
import ballerina/test;

@test:Config {}
function testFunc() returns error? {
    http:Client httpEndpoint = check new("http://localhost:9090");
    string payload = check httpEndpoint->get("/company/employee/23");
    test:assertEquals(payload, "Employee data");
}
