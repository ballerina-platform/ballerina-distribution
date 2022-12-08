import ballerina/http;
import ballerina/test;

@test:Config {}
function testFunc() returns error? {
    http:Client testClient = check new("localhost:9090");
    json payload = check testClient->get("/albums;artist=John-Coltrane/Blue-Train");
    test:assertEquals(payload, {title:"Blue-Train", artist:"John-Coltrane"});

    http:Response res = check testClient->get("/albums;artist=John/Blue-Train");
    test:assertEquals(res.statusCode, 400);
}
