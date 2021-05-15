import ballerina/http;
import ballerina/test;

@test:Config {}
function testFunc() returns @tainted error? {

    http:Client httpEndpoint = checkpanic new("http://localhost:9090");

    var response = httpEndpoint->get("/sample/path;a=4;b=5/value1;x=10;y=15", targetType = json);
    if (response is json) {
        test:assertEquals(response, {"pathParam":"value1","matrix":{"path":"a=4, b=5","foo":"x=10, y=15"}});
    } else {
        test:assertFail(msg = "Failed to call the endpoint");
    }
}
