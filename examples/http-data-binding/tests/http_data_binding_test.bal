import ballerina/http;
import ballerina/test;

@test:Config{}
function testFunc() returns error? {
    http:Client httpEndpoint = check new("http://localhost:9090");

    json reqPayload = { "Name": "John", "Grade": 12};
    string expectedJson = "John";
    string jsonResponse = check httpEndpoint->post("/info/student", reqPayload);
    test:assertEquals(jsonResponse, expectedJson);

    xml xmlPayload = xml `<h:Store id ="AST" xmlns:h="http://www.test.com"><h:street>Main</h:street><h:city>94</h:city></h:Store>`;
    xml expectedXml = xml `<h:city xmlns:h="http://www.test.com">94</h:city>`;
    xml xmlResponse = check httpEndpoint->post("/info/store", xmlPayload);
    test:assertEquals(xmlResponse, expectedXml);
}
