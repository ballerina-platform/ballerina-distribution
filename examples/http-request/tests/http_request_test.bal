import ballerina/http;
import ballerina/test;

table<Album> key(title) albums = table [
    {title: "Blue Train", artist: "John Coltrane"},
    {title: "Jeru", artist: "Gerry Mulligan"}
];

@test:Config {}
function testFunc() returns error? {
    http:Client albumClient = check new ("localhost:9090");
    http:Request request = new;
    request.setJsonPayload({
        title: "Sarah Vaughan and Clifford Brown",
        artist: "Sarah Vaughan"
    });
    request.setHeader("x-music-genre", "Jazz");

    Album album = check albumClient->/albums.post(request);
    test:assertEquals(album, {"title":"Sarah Vaughan and Clifford Brown", "artist":"Sarah Vaughan"});
}


service / on new http:Listener(9090) {
    resource function post albums(@http:Payload Album album) returns Album {
        albums.add(album);
        return album;
    }
}
