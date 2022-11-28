import ballerina/http;
import ballerina/test;

@test:Config {}
function testFunc() returns error? {
    http:Client httpEndpoint = check new("localhost:9090");
    http:Response response = check httpEndpoint->get("/greeting");
    test:assertEquals(response.getHeader("transfer-encoding"), "chunked");
}
