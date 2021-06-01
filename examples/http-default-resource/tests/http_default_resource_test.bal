import ballerina/http;
import ballerina/test;

@test:Config {}
function testFunc() returns @tainted error? {
    http:Client httpEndpoint = check new("http://localhost:9090");
    json response = check httpEndpoint->get("/foo/bar");
    test:assertEquals(response, {"method":"GET","path":["foo","bar"]});
}
