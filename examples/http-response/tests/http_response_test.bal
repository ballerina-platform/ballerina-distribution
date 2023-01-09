import ballerina/http;
import ballerina/test;

table<Album> key(title) albums = table [
    {title: "Blue Train", artist: "John Coltrane"},
    {title: "Jeru", artist: "Gerry Mulligan"}
];

@test:Config {}
function testFunc() returns error? {
    http:Client albumClient = check new ("localhost:9090");
    http:Response response = check albumClient->/albums({"x-music-genre": "Jazz"});
    test:assertEquals(response.getHeader("x-music-genre"), "Jazz");
}

service / on new http:Listener(9090) {

    resource function get albums(@http:Header string x\-music\-genre) returns record {|*http:Ok; Album[] body;|} {
        return {body: albums.toArray(), headers: {"x-music-genre": x\-music\-genre}};
    }
}
