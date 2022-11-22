import ballerina/test;
import ballerina/http;

@test:Config {}
function testFunc() returns error? {
    http:Client httpEndpoint = check new("localhost:9090");

    http:Response response = check httpEndpoint->get("/greeting");
    test:assertEquals(response.getHeader("etag"), "ec4ac3d0");
    test:assertEquals(response.getHeader("cache-control"), "must-revalidate,public,max-age=15");
    test:assertFalse(response.hasHeader("age"));
    test:assertEquals(response.getTextPayload(), "Hello, World!");

    response = check httpEndpoint->get("/greeting");
    test:assertEquals(response.getHeader("etag"), "ec4ac3d0");
    test:assertEquals(response.getHeader("cache-control"), "must-revalidate,public,max-age=15");
    test:assertTrue(response.hasHeader("age"));
    test:assertEquals(response.getTextPayload(), "Hello, World!");
}
