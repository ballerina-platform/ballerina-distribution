import ballerina/http;
import ballerina/test;

@test:Config {}
function testFunc() returns @tainted error? {
    http:Client httpEndpoint = checkpanic new("http://localhost:9090");
    json response = check httpEndpoint->get("/sample/path/value1");
    test:assertEquals(response, {"pathParam":"value1"});
}
