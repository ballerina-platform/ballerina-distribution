import ballerina/test;
import ballerina/http;

@test:Config {}
function testFunc() returns error? {
    http:Client httpEndpoint = check new("localhost:9090");
    http:Response response = check httpEndpoint->get("/albums");
    test:assertEquals(response.getHeader("x-music-genre"), "Jazz");
}
