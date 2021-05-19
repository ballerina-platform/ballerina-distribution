import ballerina/http;
import ballerina/test;

@test:Config {}
function testFunc() returns @tainted error? {

    http:Client httpEndpoint = check new("http://localhost:9090");

    json payload = {"method":"GET","path":["foo","bar"]};
    var response = httpEndpoint->get("/foo/bar", targetType = json);
    if (response is json) {
        test:assertEquals(response, payload);
    } else {
        test:assertFail(msg = "Failed to call the endpoint");
    }

    response = httpEndpoint->get("/greeting", targetType = string);
    if (response is string) {
        test:assertEquals(response, "Specific resource is invoked");
    } else {
        test:assertFail(msg = "Failed to call the endpoint");
    }
}
