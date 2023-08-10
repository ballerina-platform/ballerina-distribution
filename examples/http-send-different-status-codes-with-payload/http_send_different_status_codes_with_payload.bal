import ballerina/http;

type Album readonly & record {|
    string title;
    string artist;
|};

// Represents the subtype of http:Conflict status code record.
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

    // The resource returns the `409 Conflict` status code as the error response status code using the built-in `StatusCodeResponse`.
    resource function post albums(Album album) returns Album|AlbumConflict {
        if albums.hasKey(album.title) {
            return {body: { message: "album already exists" }};
        }
        albums.add(album);
        return album;
    }
}
