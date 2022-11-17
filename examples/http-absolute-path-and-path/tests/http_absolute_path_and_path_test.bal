import ballerina/test;
import ballerina/http;

@test:Config {}
function testFunc() returns error? {
    http:Client httpEndpoint = check new("http://localhost:9090");
    Album[] payload = check httpEndpoint->get("/info/albums");
    test:assertEquals(payload, [{title:"Blue Train",artist:"John Coltrane"},{title:"Jeru",artist:"Gerry Mulligan"}]);
}
