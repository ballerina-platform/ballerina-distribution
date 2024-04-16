import ballerina/http;

type Album readonly & record {|
    string title;
    string artist;
|};

table<Album> key(title) albums = table [
    {title: "Blue Train", artist: "John Coltrane"},
    {title: "Jeru", artist: "Gerry Mulligan"}
];

// The `service path` represents the absolute path to the service.
// If the `service path` is omitted, then it defaults to `/`.
// It can be represented by both identifiers and string literals. E.g., `/music\-info`, `"/music-info"`.
service /info on new http:Listener(9090) {

    // The `resource path` represents the relative path to the resource and the `resource accessor`
    // represents the HTTP method that is used to access the resource.
    // Here, the resource path is `/albums` and the resource accessor is `get` which means that the
    // resource is invoked when an HTTP GET request is made to `/info/albums`.
    // The `resource path` can be set as `.` to represent a resource with the `service path` 
    // that is `/info`.
    resource function get albums() returns Album[] {
        return albums.toArray();
    }
}
