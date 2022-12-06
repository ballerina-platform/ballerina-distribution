import ballerina/http;
import ballerina/io;

type Album readonly & record {
    string title;
    string artist;
};

public function main() returns error? {
    http:Client albumClient = check new ("localhost:9090");

    // Sends a `GET` request to the "/albums" resource.
    // The query parameter can be provided as parameters in the `get` method invocation.
    Album[] albums = check albumClient->/albums(artist = "John Coltrane");
    io:println("Received albums: " + albums.toJsonString());

    // Sends a `POST` request to the "/album" resource.
    // The query parameter can be provided as parameters in the `post` method invocation.
    string albumId = check albumClient->/album.post({
            title: "Sarah Vaughan and Clifford Brown",
            artist: "Sarah Vaughan"
        },
        apiVersion = 2
    );
    io:println("Added album with id: " + albumId);

}
