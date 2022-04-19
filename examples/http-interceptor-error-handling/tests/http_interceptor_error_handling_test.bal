import ballerina/http;
import ballerina/test;

@test:Config{}
function testFunc() returns error? {
    json expectedBody = {
        message : "Greetings!"
    };
    http:Client clientEP = check new("http://localhost:9090");
    http:Response res = check clientEP->get("/greeting");
    test:assertEquals(res.statusCode, 200);
    test:assertEquals(check res.getHeader("checkedHeader"), "RequestErrorInterceptor");
    test:assertEquals(res.getContentType(), "application/org+json");
    test:assertEquals(check res.getJsonPayload(), expectedBody);
}
