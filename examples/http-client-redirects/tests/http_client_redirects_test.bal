import ballerina/test;
import ballerina/http;

table<Album> key(title) albums = table [
    {title: "Blue Train", artist: "John Coltrane"},
    {title: "Jeru", artist: "Gerry Mulligan"}
];

@test:Config {}
function testFunc() returns error? {
    http:Client httpEndpoint = check new ("localhost:9092",
    followRedirects = {enabled: true, maxCount: 5});

    // Send a GET request to the specified endpoint
    Album[] response = check httpEndpoint->get("/redirect");
    test:assertEquals(response, [{"title":"Blue Train", "artist":"John Coltrane"}, {"title":"Jeru", "artist":"Gerry Mulligan"}]);
}

service / on new http:Listener(9092) {

    resource function get redirect() returns http:TemporaryRedirect {
        // Return a redirect response record with the location header.
        return {headers: {"Location": "http://localhost:9090/albums"}};
    }
}

service / on new http:Listener(9090) {

    resource function get albums() returns Album[] {
        return albums.toArray();
    }

    resource function post albums(@http:Payload Album album) returns Album {
        albums.add(album);
        return album;
    }
}
