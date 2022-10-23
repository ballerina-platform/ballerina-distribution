import ballerina/http;
import ballerina/test;

@test:Config {}
function testFunc() returns error? {
    http:Client httpEndpoint = check new("http://localhost:9090");
    http:Response response = check httpEndpoint->get("/passthrough");
    test:assertEquals(response.statusCode, 200);
}
