import ballerina/test;
import ballerina/http;

@test:Config {}
function testFunc() returns error? {
    http:Client httpEndpoint = check new("http://localhost:9090");
    json expectedJson = {id: "data-binding-done"};

    http:Response|error resp = httpEndpoint->get("/call/all");
    if (resp is http:Response) {
        var jsonPayload = check resp.getJsonPayload();
        test:assertEquals(jsonPayload, expectedJson);
    } else {
        test:assertFail(msg = "Failed to call the endpoint:");
    }

    resp = httpEndpoint->get("/call/5xx");
    if (resp is http:Response) {
        var jsonPayload = check resp.getJsonPayload();
        test:assertEquals(jsonPayload, {code:501, payload:"data-binding-failed-with-501"});
    } else {
        test:assertFail(msg = "Failed to call the endpoint:");
    }

    resp = httpEndpoint->get("/call/4xx");
    if (resp is http:Response) {
        var jsonPayload = check resp.getJsonPayload();
        test:assertEquals(jsonPayload, {code:404, payload:"no matching resource found for path : /backend/err , method : POST"});
    } else {
        test:assertFail(msg = "Failed to call the endpoint:");
    }

}
