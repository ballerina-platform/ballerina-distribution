import ballerina/http;
import ballerina/test;

@test:Config{}
function testFunc() returns error? {
    json expectedBody = {
        message : "no header value found for 'x-api-version'"
    };
    http:Client clientEP = check new("localhost:9090");
    http:Response res = check clientEP->get("/albums");
    test:assertEquals(res.statusCode, 400);
    test:assertEquals(res.getContentType(), "application/org+json");
    test:assertEquals(check res.getJsonPayload(), expectedBody);
}
