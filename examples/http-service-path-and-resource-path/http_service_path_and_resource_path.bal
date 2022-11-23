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
// To access the service, the `service path` is placed next to the host(and port) in the request URL.
// If the `service path` is omitted, then it defaults to `/`.
// The `service path` can be represented by both identifiers and string literals. E.g., `/music\-info`, `"/music-info"`.
service /info on new http:Listener(9090) {

    // The `resource accessor` (`get`) confines the resource to the specified HTTP methods. In this instance, only `GET` requests are allowed.
    // The `resource path` associates the relative path to the service object's path. E.g., `albums`.
    // The `.` represents the current resource that is `/`.
    resource function get albums() returns Album[] {
        return albums.toArray();
    }
}
