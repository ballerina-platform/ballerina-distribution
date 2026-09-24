import ballerina/http;
import ballerina/io;

type Album readonly & record {
    string title;
    string artist;
};

public function main() returns error? {
    http:Client albumClient = check new ("localhost:9090");

    // Sends a `GET` request to the "/albums" resource.
    // The query parameter can be provided as a parameter in the `get` method invocation.
    Album[] albums = check albumClient->/albums(artist = "John Coltrane");
    io:println("Received albums: " + albums.toJsonString());

    // Multiple query parameters can be passed as an `http:QueryParams` value.
    http:QueryParams queries = {
        "title": "Blue Train",
        "artist": "John Coltrane"
    };
    albums = check albumClient->/albums(params = queries);
    io:println("Received albums: " + albums.toJsonString());

    // Multiple query parameters can also be passed using a map.
    albums = check albumClient->/albums(params = {
        "title": "Blue Train",
        "artist": "John Coltrane"
    });
    io:println("Received albums: " + albums.toJsonString());
}
