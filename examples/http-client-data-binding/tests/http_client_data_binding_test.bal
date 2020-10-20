import ballerina/test;
import ballerina/http;

@test:Config {}
function testFunc() returns @tainted error? {
    http:Client httpEndpoint = new("http://localhost:909o");
    json expectedJson = {id: "data-binding-done"};

    var resp = httpEndpoint->get("/call/all");
    if (resp is http:Response) {
        var jsonPayload = check resp.getJsonPayload();
        test:assertEquals(jsonPayload, expectedJson);
    } else {
        test:assertFail(msg = "Failed to call the endpoint:");
    }

    resp = httpEndpoint->get("/call/5xx");
    if (resp is http:Response) {
        var textPayload = check resp.getTextPayload();
        test:assertEquals(textPayload, "data-binding-failed-with-501");
        test:assertEquals(resp.statusCode, 501);
    } else {
        test:assertFail(msg = "Failed to call the endpoint:");
    }

    resp = httpEndpoint->get("/call/4xx");
    if (resp is http:Response) {
        var textPayload = check resp.getTextPayload();
        test:assertEquals(textPayload, "resource not found");
        test:assertEquals(resp.statusCode, 404);
    } else {
        test:assertFail(msg = "Failed to call the endpoint:");
    }
}
