import ballerina/test;
import ballerina/http;

@test:Config {
}
function testFunc() returns error? {
    http:Client httpEndpoint = check new("http://localhost:9090");

    string response = check httpEndpoint->get("/lb");
    test:assertEquals(response, "Mock1 resource was invoked.");

    response = check httpEndpoint->get("/lb");
    test:assertEquals(response, "Mock2 resource was invoked.");

    response = check httpEndpoint->get("/lb");
    test:assertEquals(response, "Mock3 resource was invoked.");

    response = check httpEndpoint->get("/lb");
    test:assertEquals(response, "Mock1 resource was invoked.");
}
