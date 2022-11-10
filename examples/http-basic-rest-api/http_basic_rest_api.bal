import ballerina/http;

type Album readonly & record {|
    string title;
    string artist;
|};

table<Album> key(title) albums = table [
    {title: "Blue Train", artist: "John Coltrane" },
    {title: "Jeru", artist: "Gerry Mulligan"}
];

service / on new http:Listener(9090) {

    // Retrieves all the album as an array
    resource function get albums() returns Album[] {
        return albums.toArray();
    }

    // Creates an album using the inbound payload
    resource function post albums(@http:Payload Album album) returns Album {
        albums.add(album);
        return album;
    }
}
