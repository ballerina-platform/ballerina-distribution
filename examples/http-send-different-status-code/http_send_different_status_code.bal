import ballerina/http;

type Album readonly & record {|
    string title;
    string artist;
|};

// Represents the subtype of http:Conflict status code record
type AlbumConflict record {|
    *http:Conflict;
    record {
        string message;
    } body;
|};

table<Album> key(title) albums = table [
    {title: "Blue Train", artist: "John Coltrane"},
    {title: "Jeru", artist: "Gerry Mulligan"}
];

service / on new http:Listener(9090) {

    // The resource returns `409 Conflict` status code as the error response status code using build in StatusCodeResponse
    // For details, see https://lib.ballerina.io/ballerina/http/latest/types#StatusCodeResponse.
    resource function post albums(@http:Payload Album album) returns Album|AlbumConflict {
        if albums.hasKey(album.title) {
            return {body: { message: "album already exists" }};
        }
        albums.add(album);
        return album;
    }
}
