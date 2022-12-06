import ballerina/http;
import ballerina/io;

type Album readonly & record {
    string title;
    string artist;
};

public function main(string artist) returns error? {
    http:Client albumClient = check new ("localhost:9090");

    // Sends a `GET` request to the "/albums" resource.
    // The path parameter can be defined inside `[]` after the path followed by a `/`.
    // This is the same as invoking the get method by `albumClient->get("/albums/Blue Train")`.
    Album album = check albumClient->/albums/[artist];
    io:println("Received album: " + album.toJsonString());
}
