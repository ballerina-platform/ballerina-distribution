import ballerina/test;
import ballerina/http;

@test:Config {}
function testFunc() returns error? {
    http:Client httpEndpoint = check new("http://localhost:9090");
    Album[] payload = check httpEndpoint->get("/albums");
    test:assertEquals(payload, [{title:"Blue Train",artist:"John Coltrane"},{title:"Jeru",artist:"Gerry Mulligan"}]);


    Album lastAlbum = check httpEndpoint->post("/albums", {title:"Sarah Vaughan and Clifford Brown", artist:"Sarah Vaughan"});
    test:assertEquals(lastAlbum, {title:"Sarah Vaughan and Clifford Brown", artist:"Sarah Vaughan"});
}
