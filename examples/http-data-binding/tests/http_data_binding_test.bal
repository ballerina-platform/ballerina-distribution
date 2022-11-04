import ballerina/http;
import ballerina/test;

@test:Config{}
function testFunc() returns error? {
    http:Client httpEndpoint = check new("http://localhost:9090");

    json reqPayload = { "name": "John", "grade": 12};
    string expectedJson = "Student data of 'John' is updated";
    string jsonResponse = check httpEndpoint->post("/register/student", reqPayload);
    test:assertEquals(jsonResponse, expectedJson);
}
