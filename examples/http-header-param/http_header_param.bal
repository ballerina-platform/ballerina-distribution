import ballerina/http;
import ballerina/mime;

type Album readonly & record {|
    string title;
    string artist;
|};

table<Album> key(title) albums = table [
    {title: "Blue Train", artist: "John Coltrane"},
    {title: "Jeru", artist: "Gerry Mulligan"}
];

service / on new http:Listener(9090) {

    // The `accept` argument with `@http:Header` annotation takes the value of the `Accept` request header.
    resource function get albums(@http:Header string accept) returns Album[]|http:NotAcceptable {
        if !string:equalsIgnoreCaseAscii(accept, mime:APPLICATION_JSON) {
            return http:NOT_ACCEPTABLE;
        }
        return albums.toArray();
    }
}
