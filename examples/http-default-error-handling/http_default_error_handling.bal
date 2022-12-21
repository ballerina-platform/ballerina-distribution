import ballerina/http;

type Album readonly & record {|
    string title;
    string artist;
|};

service / on new http:Listener(9090) {

    resource function get artist() returns string|error {
        // Creates a new client with an invalid endpoint URL.
        http:Client albumClient = check new ("localhost:9091");
        Album[] albums = check albumClient->/albums;
        return "First artist name: " + albums[0].artist;
    }
}
