import ballerina/http;
import ballerina/test;

@test:Config{}
function testFunc() returns error? {
    http:Client clientEP = check new("http://localhost:9090");
    http:Response res = check clientEP->get("/user/greeting");
    test:assertEquals(res.statusCode, 200);
    test:assertEquals(check res.getHeader("requestHeader1"), "RequestInterceptor1");
    test:assertEquals(check res.getHeader("requestHeader2"), "RequestInterceptor2");
    test:assertEquals(check res.getTextPayload(), "Greetings!");
}
