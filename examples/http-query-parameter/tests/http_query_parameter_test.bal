import ballerina/http;
import ballerina/test;

@test:Config {}
function testFunc() returns error? {
    http:Client httpEndpoint = check new("localhost:9090");
    Album[] payload = check httpEndpoint->get("/albums?year=1958");
    test:assertEquals(payload, [{title:"Blue Train", artist:"John Coltrane", year:1958}]);

    payload = check httpEndpoint->get("/albums?year=1957");
    test:assertEquals(payload, []);
}
