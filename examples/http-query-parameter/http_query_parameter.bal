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

    // The `artist` resource method argument is considered as the query parameter which is extracted from the request URI.
    resource function get albums(string artist) returns Album[] {
        return from Album album in albums
               where album.artist == artist
               select album;
    }
}
