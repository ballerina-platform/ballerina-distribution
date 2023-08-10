import ballerina/http;
import ballerina/test;

@test:Config{}
function testFunc() returns error? {
    http:Client clientEP = check new("localhost:9090");
    http:Response res = check clientEP->get("/albums", {"x-api-version": "v1"});
    test:assertEquals(res.statusCode, 200);

    res = check clientEP->get("/albums", {"x-api-version": "v2"});
    test:assertEquals(res.statusCode, 501);
}
