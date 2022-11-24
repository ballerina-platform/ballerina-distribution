import ballerina/http;

type Album readonly & record {|
    string title;
    string artist;
|};

table<Album> key(title) albums = table [
    {title: "Blue Train", artist: "John Coltrane" },
    {title: "Jeru", artist: "Gerry Mulligan"}
];

// The `service path` represents the absolute path to the service.
// If the `service path` is omitted, then it defaults to `/`.
// It can be represented by both identifiers and string literals. E.g., `/music\-info`, `"/music-info"`.
service /info on new http:Listener(9090) {

    // The `resource name` is `albums` and the `resource accessor` is `get`.
    // The `.` represents the current resource that is `/`.
    resource function get albums() returns Album[] {
        return albums.toArray();
    }
}
