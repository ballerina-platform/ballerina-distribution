import ballerina/http;
import ballerina/io;
import ballerina/mime;

type Album readonly & record {
    string title;
    string artist;
};

public function main() returns error? {
    http:Client albumClient = check new ("localhost:9090");

    Album[] albums = check albumClient->/albums({
        Accept: mime:APPLICATION_JSON
    });
    io:println("Received albums: " + albums.toJsonString());
}
