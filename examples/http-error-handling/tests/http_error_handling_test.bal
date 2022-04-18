import ballerina/http;
import ballerina/test;

@test:Config{}
function testFunc() returns error? {
    http:Client clientEP = check new("http://localhost:9090");
    http:Response res = check clientEP->get("/greeting");
    test:assertEquals(check res.getTextPayload(), "Greetings from Interceptor!");
    test:assertEquals(check res.getHeader("X-checkHeader"), "ResponseErrorInterceptor");

    res = check clientEP->get("/greeting", {"X-interceptorCheckHeader" : "true"});
    test:assertEquals(check res.getTextPayload(), "Greetings!");
    test:assertEquals(check res.getHeader("X-checkHeader"), "RequestErrorInterceptor");

    res = check clientEP->get("/greeting", {"X-checkHeader" : "CheckHeader"});
    test:assertEquals(check res.getTextPayload(), "Greetings!");
    test:assertEquals(check res.getHeader("X-checkHeader"), "CheckHeader");
}
