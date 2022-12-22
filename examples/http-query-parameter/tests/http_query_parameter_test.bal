import ballerina/http;
import ballerina/test;

@test:Config {}
function testFunc() returns error? {
    http:Client httpEndpoint = check new("localhost:9090");
    json[] payload = check httpEndpoint->/albums(artist="John Coltrane");
    test:assertEquals(payload, [{title:"Blue Train", artist:"John Coltrane"}]);

    payload = check httpEndpoint->/albums(artist="John");
    test:assertEquals(payload, []);
}
