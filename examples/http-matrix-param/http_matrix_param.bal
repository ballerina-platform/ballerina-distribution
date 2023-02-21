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

    resource function get albums/[string title](http:Request req) returns Album|http:NotFound|http:BadRequest {
        Album? album = albums[title];
        if album is () {
            return http:NOT_FOUND;
        }

        // Gets the `MatrixParams` of the path `/albums`.
        map<any> pathMParams = req.getMatrixParams("/albums");
        string artist = <string>pathMParams["artist"];

        if album.artist != artist {
            return http:BAD_REQUEST;
        }
        return album;
    }
}
