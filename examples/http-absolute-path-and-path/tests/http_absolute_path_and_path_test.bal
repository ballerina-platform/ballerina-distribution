import ballerina/test;
import ballerina/http;

@test:Config {}
function testFunc() returns error? {
    http:Client httpEndpoint = check new("http://localhost:9090");
    string payload = check httpEndpoint->post("/register/student", "Mike");
    test:assertEquals(payload, "Student data of 'Mike' is updated");
}
