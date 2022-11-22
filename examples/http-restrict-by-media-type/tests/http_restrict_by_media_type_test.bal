import ballerina/http;
import ballerina/test;

@test:Config {}
function testFunc() returns error? {
    http:Client testClient = check new("localhost:9090");
    xml payload = check testClient->post("/transform", "Ballerina");
    test:assertEquals(payload, xml `<name>Ballerina</name>`);

    xml|error err = testClient->post("/transform", "WSO2");
    if err is http:RemoteServerError {
        test:assertEquals(err.detail().body, xml `<name>invalid string</name>`);
    }
}
