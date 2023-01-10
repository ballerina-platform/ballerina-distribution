import ballerina/http;
import ballerina/io;

type Album readonly & record {
    string title;
    string artist;
};

public function main() returns error? {
    http:Client albumClient = check new ("localhost:9090");

    // Create a request and populate headers/payload.
    http:Request request = new;
    request.setHeader("x-music-genre", "Jazz");
    request.setJsonPayload({
        title: "Sarah Vaughan and Clifford Brown",
        artist: "Sarah Vaughan"
    });

    Album album = check albumClient->/albums.post(request);
    io:println("Created album:" + album.toJsonString());
}
