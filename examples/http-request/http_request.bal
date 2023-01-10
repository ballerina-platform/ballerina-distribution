import ballerina/http;
import ballerina/io;

type Album readonly & record {
    string title;
    string artist;
};

public function main() returns error? {
    http:Client albumClient = check new ("localhost:9090");

    http:Request request = new;
    request.setJsonPayload({
        title: "Sarah Vaughan and Clifford Brown",
        artist: "Sarah Vaughan"
    });
    request.setHeader("x-music-genre", "Jazz");

    Album album = check albumClient->/albums.post(request);
    io:println("Created album:" + album.toJsonString());
}
