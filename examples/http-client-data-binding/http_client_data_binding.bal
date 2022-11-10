import ballerina/http;

type Album readonly & record {|
    string title;
    string artist;
|};

http:Client httpClient = check new("http://localhost:9092");

service / on new http:Listener(9090) {
    resource function get artist() returns string|error {
        // Binding the payload to a `record` array type. The contextually expected type is inferred from the LHS variable type.
        Album[] albums = check httpClient->/albums;
        return albums[0].artist;
    }
}

service / on new http:Listener(9092) {
    resource function get albums() returns Album[] {
        Album[] albums = [{title: "Blue Train", artist: "John Coltrane" },
            {title: "Jeru", artist: "Gerry Mulligan"}];
        return albums;
    }
}
