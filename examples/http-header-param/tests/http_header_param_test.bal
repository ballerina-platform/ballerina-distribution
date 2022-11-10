import ballerina/http;
import ballerina/test;

@test:Config {}
function testFunc() returns error? {
    http:Client testClient = check new("http://localhost:9090");
    Album[] payload = check testClient->get("/albums", {"Accept":"application/json"});
    test:assertEquals(payload, [{title:"Blue Train",artist:"John Coltrane"},{title:"Jeru",artist:"Gerry Mulligan"}]);

    Album|error response = testClient->get("/albums", {"Accept":"application/xml"});
    if response is http:ClientRequestError {
        test:assertEquals(response.detail().statusCode, 406);
    } else {
        test:assertFail("Unexpected status code");
    }
}
