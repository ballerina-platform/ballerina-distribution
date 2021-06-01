import ballerina/http;
import ballerina/test;

@test:Config {}
function testFunc() returns error? {
    http:Client httpEndpoint = checkpanic new("http://localhost:9090");
    json response = check httpEndpoint->get("/sample/path;a=4;b=5/value1;x=10;y=15");
    test:assertEquals(response, {"pathParam":"value1","matrix":{"path":"a=4, b=5","foo":"x=10, y=15"}});
}
