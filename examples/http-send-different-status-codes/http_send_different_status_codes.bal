import ballerina/http;

type Album readonly & record {|
    string title;
    string artist;
|};

table<Album> key(title) albums = table [
    {title: "Blue Train", artist: "John Coltrane"},
    {title: "Jeru", artist: "Gerry Mulligan"}
];

service / on new http:Listener(9090) {

    // The resource returns the `409 Conflict` status code as the error response status code using 
    // the `StatusCodeResponse` constants. This constant does not have a body or headers.
    resource function post albums(Album album) returns Album|http:Conflict {
        if albums.hasKey(album.title) {
            return http:CONFLICT;
        }
        albums.add(album);
        return album;
    }
}
