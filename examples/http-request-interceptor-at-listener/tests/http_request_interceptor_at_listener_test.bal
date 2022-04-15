import ballerina/http;
import ballerina/test;

@test:Config{}
function testFunc() returns error? {
    http:Client clientEP = check new("http://localhost:9090");
    http:Response res = check clientEP->get("/greeting");
    test:assertEquals(check res.getTextPayload(), "Greetings!");
    test:assertEquals(check res.getHeader("X-requestHeader1"), "RequestInterceptor1");
    test:assertEquals(check res.getHeader("X-requestHeader2"), "RequestInterceptor2");
}
