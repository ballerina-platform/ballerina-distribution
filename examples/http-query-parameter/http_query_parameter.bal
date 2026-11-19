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

    // The `artist` and `title` resource method arguments are considered as query parameters extracted from the request URI.
    // The `artist` query parameter is required, while the `title` query parameter is optional.
    resource function get albums(string artist, string? title = ()) returns Album[] {
        return from Album album in albums
            where album.artist == artist
                && (title is () || album.title == title)
            select album;
    }
}
