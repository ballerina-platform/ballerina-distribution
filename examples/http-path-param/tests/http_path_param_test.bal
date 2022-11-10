import ballerina/http;
import ballerina/test;

@test:Config {}
function testFunc() returns error? {
    http:Client httpEndpoint = check new("http://localhost:9090");
    Album payload = check httpEndpoint->get("/albums/Blue Train");
    test:assertEquals(payload, {title:"Blue Train", artist:"John Coltrane"});

    Album|error response = httpEndpoint->get("/albums/abba");
    if response is http:ClientRequestError {
        test:assertEquals(response.detail().statusCode, 404);
    } else {
        test:assertFail("Unexpected status code");
    }
}
