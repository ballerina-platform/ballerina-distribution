import ballerina/http;
import ballerina/test;

@test:Config {}
function testFunc() returns error? {
    http:Client httpEndpoint = check new ("localhost:9092");
    http:Response response = check httpEndpoint->get("/passthrough");
    test:assertEquals(response.statusCode, 200);
}

table<Album> key(title) albums = table [
    {title: "Blue Train", artist: "John Coltrane"},
    {title: "Jeru", artist: "Gerry Mulligan"}
];

service / on new http:Listener(9090) {

    resource function get albums() returns Album[] {
        return albums.toArray();
    }

    resource function post albums(Album album) returns Album {
        albums.add(album);
        return album;
    }
}
