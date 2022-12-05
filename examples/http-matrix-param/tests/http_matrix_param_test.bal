import ballerina/http;
import ballerina/test;

type Params record {|
    string path;
    json matrix;
|};

@test:Config {}
function testFunc() returns error? {
    http:Client testClient = check new("localhost:9090");
    Params response = check testClient->get("/params;a=4;b=5/value1");
    test:assertEquals(response, {"path":"value1","matrix":{"a":"4","b":"5"}});
}
