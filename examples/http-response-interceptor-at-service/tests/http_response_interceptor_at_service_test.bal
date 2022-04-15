import ballerina/http;
import ballerina/test;

@test:Config{}
function testFunc() returns error? {
    http:Client clientEP = check new("http://localhost:9090");
    http:Response res = check clientEP->get("/user/greeting");
    test:assertEquals(check res.getTextPayload(), "Greetings from Interceptor!");
    test:assertEquals(check res.getHeader("X-responseHeader1"), "ResponseInterceptor1");
    test:assertEquals(check res.getHeader("X-responseHeader2"), "ResponseInterceptor2");
}
