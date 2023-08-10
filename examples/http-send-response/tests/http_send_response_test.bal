import ballerina/http;
import ballerina/test;

@test:Config {}
function testFunc() returns error? {
    http:Client testClient = check new("localhost:9090");
    Album[] payload = check testClient->get("/albums");
    test:assertEquals(payload, [{title:"Blue Train",artist:"John Coltrane"},{title:"Jeru",artist:"Gerry Mulligan"}]);
}
