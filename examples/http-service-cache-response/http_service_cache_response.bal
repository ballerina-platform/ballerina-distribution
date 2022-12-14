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

    // In this example, `max-age` directive is set to 15 seconds, indicating that the response
    // will be fresh for 15 seconds. By default, `must-revalidate` directive is true and instructs that
    // the cache should not serve a stale response without validating it with the origin server
    // first.
    resource function get albums/[string title]() returns @http:Cache {maxAge: 15} Album|http:NotFound {
        return albums[title] ?: http:NOT_FOUND;
    }
}
