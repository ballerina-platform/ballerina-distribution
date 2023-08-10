import ballerina/test;
import ballerina/http;

type Album readonly & record {|
    string title;
    string artist;
|};

table<Album> key(title) albums = table [
    {title: "Blue Train", artist: "John Coltrane"},
    {title: "Jeru", artist: "Gerry Mulligan"}
];

@test:Config {}
function testFunc() returns error? {
    // Invoking the main function
    http:Client httpEndpoint = check new("localhost:9092",
            followRedirects = { enabled: true, maxCount: 5 });
    // Send a GET request to the specified endpoint
    Album[] response = check httpEndpoint->get("/redirect");
    test:assertEquals(response, [{"title":"Blue Train", "artist":"John Coltrane"}, {"title":"Jeru", "artist":"Gerry Mulligan"}]);
}

service / on new http:Listener(9090) {

    resource function get albums() returns Album[] {
        return albums.toArray();
    }

    resource function post albums(Album album) returns Album {
        albums.add(album);
        return album;
    }
}
