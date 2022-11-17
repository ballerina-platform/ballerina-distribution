import ballerina/http;
import ballerina/test;

@test:Config {}
function testFunc() returns error? {
    http:Client testClient = check new("http://localhost:9090");
    http:Response response = check testClient->post("/albums", {title:"Sarah Vaughan and Clifford Brown", artist:"Sarah Vaughan"});
    test:assertEquals(response.statusCode, 201);

    response = check testClient->post("/albums", {title:"Blue Train", artist:"John Coltrane"});
    test:assertEquals(response.statusCode, 409);
}
