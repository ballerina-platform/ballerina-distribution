import ballerina/http;
import ballerina/test;

@test:Config {}
function testFunc() returns error? {
    http:Client testClient = check new("localhost:9090");
    Params response = check testClient->get("/params;a=4;b=5/value1;x=10;y=15");
    test:assertEquals(response, {"path":"value1","matrix":{"path":"a=4, b=5","foo":"x=10, y=15"}});
}
