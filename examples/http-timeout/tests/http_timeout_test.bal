import ballerina/test;
import ballerina/http;

@test:Config {}
function testFunc() returns error? {
    http:Client httpEndpoint = check new("http://localhost:9090");
    string|error response = httpEndpoint->get("/timeout");
    if (response is http:RemoteServerError) {
        test:assertEquals(<string> response.detail().body, "Request timed out. Please try again in sometime.");
    }
}
