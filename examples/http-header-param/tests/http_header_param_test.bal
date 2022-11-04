import ballerina/http;
import ballerina/test;

@test:Config {}
function testFunc() returns error? {
    http:Client testClient = check new("http://localhost:9090");
    string payload = check testClient->get("/info/student", {"trace-id":"0xf7c32f4c"});
    test:assertEquals(payload, "0xf7c32f4c");
}
