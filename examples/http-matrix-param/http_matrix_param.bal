import ballerina/http;

type Album readonly & record {|
    string title;
    string artist;
|};

table<Album> key(title) albums = table [
    {title: "Blue-Train", artist: "John-Coltrane"},
    {title: "Jeru", artist: "Gerry-Mulligan"}
];

service / on new http:Listener(9090) {

    // The path param is defined as a part of the resource path along with the type and it is extracted from the
    // request URI.
    resource function get albums/[string title](http:Request req) returns Album|http:NotFound|http:BadRequest {
        Album? album = albums[title];
        if album is () {
            return http:NOT_FOUND;
        }

        // Gets the `MatrixParams`.
        map<any> pathMParams = req.getMatrixParams("/albums");
        string artist = <string>pathMParams["artist"];

        if album.artist != artist {
            return http:BAD_REQUEST;
        }

        return album;
    }
}
