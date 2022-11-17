import ballerina/test;
import ballerina/http;

@test:Config {}
function testFunc() returns error? {
    http:Client httpEndpoint = check new("http://localhost:9092");
    string expected = "middleware";

    // Send a `GET` request to the specified endpoint.
    string companyResponse = check httpEndpoint->get("/crossOriginService/company", {"Origin":"http://www.bbc.com"});
    test:assertEquals(companyResponse, expected);

    var headers = {"Origin": "http://www.m3.com", "Access-Control-Request-Method": "POST"};
    // Send a `GET` request to the specified endpoint.
    http:Response|error langResponse = httpEndpoint->options("/crossOriginService/lang", headers);
    if langResponse is http:Response {
        // Asserting the header values.
        test:assertEquals(langResponse.getHeader("Access-Control-Allow-Methods"), "POST");
        test:assertEquals(langResponse.getHeader("Access-Control-Allow-Origin"), "http://www.m3.com");
    } else {
        test:assertFail(msg = "Failed to call the endpoint:");
    }
}
