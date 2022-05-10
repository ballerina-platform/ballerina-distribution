import ballerina/test;
import ballerina/http;

@test:Config {}
function testFunc() returns error? {
    http:Client httpEndpoint = check new("http://localhost:9090");

    http:Response response = check httpEndpoint->get("/cache");
    test:assertEquals(response.getHeader("etag"), "620328e8");
    test:assertEquals(response.getHeader("cache-control"), "must-revalidate,public,max-age=15");
    test:assertFalse(response.hasHeader("age"));
    test:assertEquals(response.getTextPayload(), "{\"message\":\"Hello, World!\"}");

    response = check httpEndpoint->get("/cache");
    test:assertEquals(response.getHeader("etag"), "620328e8");
    test:assertEquals(response.getHeader("cache-control"), "must-revalidate,public,max-age=15");
    test:assertTrue(response.hasHeader("age"));
    test:assertEquals(response.getTextPayload(), "{\"message\":\"Hello, World!\"}");
}
