import ballerina/http;
import ballerina/test;

@test:Config{}
function testFunc() returns error? {
    http:Client httpEndpoint = check new("http://localhost:9090");
    Album|error response = httpEndpoint->post("/albums", {title:"Sarah Vaughan and Clifford Brown", artist:"Sarah Vaughan"});
    if response is http:Error {
        test:assertEquals(response.detail()["statusCode"], 400);
        http:ErrorPayload errorResponse = check response.detail()["body"].ensureType();
        test:assertEquals(errorResponse.message, "payload validation failed: Validation failed for '$.title:maxLength' constraint(s).");
        test:assertEquals(errorResponse.status, 400);
        test:assertEquals(errorResponse.reason, "Bad Request");
        test:assertEquals(errorResponse.path, "/albums");
        test:assertEquals(errorResponse.method, "POST");
    } else {
        test:assertFail("Expected an error");
    }
}
