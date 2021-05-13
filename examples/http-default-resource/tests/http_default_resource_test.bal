import ballerina/http;
import ballerina/test;

@test:Config {}
function testFunc() returns @tainted error? {

    http:Client httpEndpoint = check new("http://localhost:9090");

    json payload = {"method":"GET","path":["foo","bar"]};
    var response = httpEndpoint->get("/foo/bar");
    if (response is http:Response) {
        var jsonRes = check response.getJsonPayload();
        test:assertEquals(jsonRes, payload);
    } else {
        test:assertFail(msg = "Failed to call the endpoint:");
    }

    string value = "Specific resource is invoked";
    response = httpEndpoint->get("/greeting");
    if (response is http:Response) {
        var res = check response.getTextPayload();
        test:assertEquals(res, value);
    } else {
        test:assertFail(msg = "Failed to call the endpoint:");
    }
}
