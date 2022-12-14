import ballerina/http;
import ballerina/test;

@test:Config{}
function testFunc() returns error? {
    http:Client clientEP = check new("localhost:9090");
    http:Response res = check clientEP->get("/albums");
    test:assertEquals(res.statusCode, 200);
    test:assertEquals(check res.getHeader("responseHeader"), "ResponseInterceptor");
}
