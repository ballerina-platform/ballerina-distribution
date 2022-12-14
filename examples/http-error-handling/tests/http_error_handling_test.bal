import ballerina/http;
import ballerina/test;

@test:Config{}
function testFunc() returns error? {
    json expectedBody = {
        message : "album is already present."
    };
    http:Client clientEP = check new("localhost:9090");
    http:Response res = check clientEP->post("/albums", {title: "Sarah Vaughan and Clifford Brown", artist: "Sarah Vaughan"});
    test:assertEquals(res.statusCode, 500);
    test:assertEquals(res.getContentType(), "application/org+json");
    test:assertEquals(check res.getJsonPayload(), expectedBody);
}
