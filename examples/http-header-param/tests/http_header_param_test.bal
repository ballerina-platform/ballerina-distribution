import ballerina/http;
import ballerina/test;

@test:Config {}
function testFunc() returns error? {
    http:Client testClient = check new("http://localhost:9090");
    string payload = check testClient->get("/header", {accept:"text/plain"});
    test:assertEquals(payload, "text/plain");
}
