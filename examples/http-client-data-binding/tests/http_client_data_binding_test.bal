import ballerina/test;
import ballerina/http;

@test:Config {}
function testFunc() returns error? {
    http:Client httpEndpoint = check new("http://localhost:9090");

    json jsonPayload = check httpEndpoint->get("/call/all");
    test:assertEquals(jsonPayload, {name:"Smith",age:15});

    jsonPayload = check httpEndpoint->get("/call/5xx");
    test:assertEquals(jsonPayload, {code:501, payload:"data-binding-failed-with-501"});

    jsonPayload = check httpEndpoint->get("/call/4xx");
    test:assertEquals(jsonPayload, {code:404, payload:"no matching resource found for path : /backend/err , method : POST"});
}
