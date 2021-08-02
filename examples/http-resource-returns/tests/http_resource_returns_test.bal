import ballerina/http;
import ballerina/test;

@test:Config {}
function testFunc() returns error? {

    http:Client httpEndpoint = checkpanic new("http://localhost:9090");

    json response1 = check httpEndpoint->get("/bank/branch");
    test:assertEquals(response1, {"branch":["Colombo, Srilanka"]});

    string response2 = check httpEndpoint->get("/bank/open");
    test:assertEquals(response2, "Bank is open");

    string|error response3 = httpEndpoint->get("/bank/close");
    if (response3 is http:RemoteServerError) {
        test:assertEquals(<string> response3.detail().body, "Bank is closed");
    } else {
        test:assertFail(msg = "Failed to call the endpoint");
    }

    json response4 = check httpEndpoint->put("/bank/account", "bal");
    test:assertEquals(response4, {"name":"bal", "accountNo":84230});
}
