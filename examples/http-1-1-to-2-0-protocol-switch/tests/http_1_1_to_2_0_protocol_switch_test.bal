import ballerina/test;
import ballerina/http;

@test:Config {}
function testFunc() returns error? {
    http:Client httpEndpoint = check new("http://localhost:9090");
    var response = httpEndpoint->get("/http11Service");
    if (response is http:Response) {
        json expectedResult = {"response":{"message":"response from http2 service"}};
        test:assertEquals(response.getJsonPayload(), expectedResult);
    } else {
        test:assertFail(msg = "Failed to call the endpoint:");
    }
}
