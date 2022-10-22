import ballerina/http;
import ballerina/test;

@test:Config {}
function testFunc() returns error? {
    http:Client testClient = check new("http://localhost:9090");
    Person payload = check testClient->get("/person");
    test:assertEquals(payload, {name:"Smith",age:15});
}
