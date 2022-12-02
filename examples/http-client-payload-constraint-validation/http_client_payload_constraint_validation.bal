import ballerina/constraint;
import ballerina/http;
import ballerina/io;

type Album record {|
    // Add a constraint for the maximum length and the minimum length.
    @constraint:String {
        maxLength: 5,
        minLength: 1
    }
    string title;
    string artist;
|};

public function main() returns error? {
    http:Client albumClient = check new ("localhost:9090");

    // Request the server for the album. If the constraint validation fails,
    // an `http:PayloadValidationError` will be returned.
    Album|http:ClientError response = albumClient->post("/albums", {
        // Here, an album which exceeds the constraints are sent to a server
        // which returns the same record again to the client.
        title: "Blue Train",
        artist: "John Coltrane"
    });
    if response is http:PayloadValidationError {
        io:println("Validation failed: ", response.message());
    } else if response is Album {
        io:println("Received albums: " + response.toJsonString());
    } else {
        io:println("Error occured: ", response);
    }
}
