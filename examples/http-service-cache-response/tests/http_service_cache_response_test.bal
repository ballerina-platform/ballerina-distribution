import ballerina/test;
import ballerina/http;

@test:Config {}
function testFunc() returns error? {
    http:Client httpEndpoint = check new("localhost:9090");

    http:Response response = check httpEndpoint->get("/albums/Blue Train");
    test:assertEquals(response.getHeader("etag"), "cf55d38");
    test:assertEquals(response.getHeader("cache-control"), "must-revalidate,public,max-age=15");
    test:assertFalse(response.hasHeader("age"));
    test:assertEquals(response.getJsonPayload(), {title:"Blue Train", artist:"John Coltrane"});

    response = check httpEndpoint->get("/albums/Blue Train");
    test:assertEquals(response.getHeader("etag"), "cf55d38");
    test:assertEquals(response.getHeader("cache-control"), "must-revalidate,public,max-age=15");
    test:assertTrue(response.hasHeader("age"));
    test:assertEquals(response.getJsonPayload(), {title:"Blue Train", artist:"John Coltrane"});
}
