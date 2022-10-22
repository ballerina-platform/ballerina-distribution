import ballerina/http;
import ballerina/test;

@test:Config {}
function testFunc() returns error? {
    http:Client testClient = check new("http://localhost:9090");
    BankInfo payload = check testClient->get("/bank/info");
    test:assertEquals(payload, { name: "ABC", branches : ["Colombo", "Kandy", "Galle"]});
}
