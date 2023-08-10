import ballerina/http;
import ballerina/constraint;
import ballerina/io;

type Album record {
    // Add a constraint for the maximum length and the minimum length.
    @constraint:String {
        maxLength: 5,
        minLength: 1
    }
    string title;
    string artist;
};

public function main() returns error? {
    http:Client albumClient = check new ("localhost:9090");

    // Request the server for the album. If the constraint validation fails,
    // an `http:PayloadValidationError` will be returned.
    Album album = check albumClient->/albums.post({
        // Here, an album which exceeds the constraints are sent to a server
        // which returns the same record again to the client.
        title: "Blue Train",
        artist: "John Coltrane"
    });
    io:println("Received album: " + album.toJsonString());
}
