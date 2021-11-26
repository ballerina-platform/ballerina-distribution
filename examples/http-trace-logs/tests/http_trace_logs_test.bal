import ballerina/http;
import ballerina/test;

@test:Config {}
function testFunc() returns error? {
    http:Client httpEndpoint = check new("http://localhost:9090");
    http:Response res = check httpEndpoint->get("/hello");
    test:assertEquals(res.statusCode, 200);
}
