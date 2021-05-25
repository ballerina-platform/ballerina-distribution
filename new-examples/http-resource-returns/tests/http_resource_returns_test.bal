import ballerina/http;
import ballerina/test;

@test:Config {}
function testFunc() returns @tainted error? {

    http:Client httpEndpoint = checkpanic new("http://localhost:9090");

    var response = httpEndpoint->get("/bank/branch", targetType = json);
    if (response is json) {
        test:assertEquals(response, {"branch":["Colombo, Srilanka"]});
    } else {
        test:assertFail(msg = "Failed to call the endpoint");
    }

    response = httpEndpoint->get("/bank/open", targetType = string);
    if (response is string) {
        test:assertEquals(response, "Bank is open");
    } else {
        test:assertFail(msg = "Failed to call the endpoint");
    }

    response = httpEndpoint->get("/bank/close", targetType = string);
    if (response is error) {
        test:assertEquals(response.message(), "Bank is closed");
    } else {
        test:assertFail(msg = "Failed to call the endpoint");
    }

    response = httpEndpoint->get("/bank/createAccount?name=bal", targetType = json);
    if (response is json) {
        test:assertEquals(response, {"name":"bal", "accountNo":84230});
    } else {
        test:assertFail(msg = "Failed to call the endpoint");
    }
}
