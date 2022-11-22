import ballerina/http;
import ballerina/test;

@test:Config {}
function testFunc() returns error? {
    http:Client httpEndpoint = check new("localhost:9090", {
        retryConfig: {
            interval: 3,
            count: 5
        }});
    string res = check httpEndpoint->get("/trace");
    test:assertEquals(res, "200 OK");
}
