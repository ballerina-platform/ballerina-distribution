import ballerina/test;
import ballerina/http;

@test:Config {}
function testFunc() returns error? {
    http:Client httpEndpoint = check new("localhost:9090");
    Album lastAlbum = check httpEndpoint->post("/albums", {title:"Sarah Vaughan and Clifford Brown", artist:"Sarah Vaughan"});
    test:assertEquals(lastAlbum, {title:"Sarah Vaughan and Clifford Brown", artist:"Sarah Vaughan"});
}
