import ballerina/test;
import ballerina/http;

@test:Config {}
function testFunc() {
    // Invoking the main function
    http:Client httpEndpoint = new("http://localhost:9090", config = {
            followRedirects: { enabled: true, maxCount: 5 }
    });

    string response1 = "Response received : Hello World!";

    // Send a GET request to the specified endpoint
    var response = httpEndpoint->get("/hello");
    if (response is http:Response) {
        var res = response.getTextPayload();
        if (res is string) {
           test:assertEquals(res, response1);
        } else {
           test:assertFail(msg = "Didn't receive the expected payload");
        }
    } else {
        test:assertFail(msg = "Failed to call the endpoint:");
    }
    return;
}
