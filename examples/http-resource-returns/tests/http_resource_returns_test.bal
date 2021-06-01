import ballerina/http;
import ballerina/test;

@test:Config {}
function testFunc() returns @tainted error? {

    http:Client httpEndpoint = checkpanic new("http://localhost:9090");

    json response1 = httpEndpoint->get("/bank/branch");
    test:assertEquals(response1, {"branch":["Colombo, Srilanka"]});

    string response2 = httpEndpoint->get("/bank/open");
    test:assertEquals(response2, "Bank is open");

    string|error response3 = httpEndpoint->get("/bank/close");
    if (response is error) {
        test:assertEquals(response3.message(), "Bank is closed");
    } else {
        test:assertFail(msg = "Failed to call the endpoint");
    }

    json response4 = httpEndpoint->get("/bank/createAccount?name=bal");
    test:assertEquals(response4, {"name":"bal", "accountNo":84230});
}
