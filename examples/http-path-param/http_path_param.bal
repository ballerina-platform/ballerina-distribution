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

    // The path param is defined as a part of the resource path within brackets
    // along with the type and it is extracted from the request URI.
    resource function get albums/[string title]() returns Album|http:NotFound {
        Album? album = albums[title];
        if album is () {
            return http:NOT_FOUND;
        }
        return album;
    }
}
