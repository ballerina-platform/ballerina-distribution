import ballerina/test;
import ballerina/http;

@test:Config {}
function testFunc() returns error? {
    http:Client httpEndpoint = check new("http://localhost:9090");
    json response = check httpEndpoint->get("/http11Service");
    json expectedResult = {"response":{"message":"response from http2 service"}};
    test:assertEquals(response, expectedResult);
}
