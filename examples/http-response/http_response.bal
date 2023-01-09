import ballerina/http;
import ballerina/io;

type Album readonly & record {
    string title;
    string artist;
};

public function main() returns error? {
    http:Client albumClient = check new ("localhost:9090");
    Album[] albums = check albumClient->/albums({"x-music-genre":"Jazz"});
    io:println("First artist name: " + albums[0].artist);
}
