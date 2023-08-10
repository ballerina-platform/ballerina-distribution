import ballerina/http;
import ballerina/test;

@test:Config {}
function testFunc() returns error? {
    http:Client albumClient = check new ("localhost:9090");
    http:Response response = check albumClient->/albums();
    test:assertEquals(response.getHeader("x-music-genre"), "Jazz");
}
