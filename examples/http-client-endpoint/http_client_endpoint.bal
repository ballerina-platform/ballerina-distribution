import ballerina/http;
import ballerina/io;

type Album readonly & record {|
    string title;
    string artist;
|};

public function main() returns error? {
    // Creates a new client with the Basic REST service URL.
    http:Client httpClient = check new ("localhost:9090");

    // Sends a `GET` request to the "/albums" resource.
    // The verb is not mandatory as it is default to "GET".
    Album[] albums = check httpClient->/albums;
    io:println("GET request:" + albums.toJsonString());

    // above call can be executed as follows using remote methods too.
    albums = check httpClient->get("/albums");

    // Sends a `POST` request to the "/albums" resource.
    Album album  = check httpClient->/albums.post({title: "Sarah Vaughan and Clifford Brown", artist: "Sarah Vaughan"});
    io:println("\nPOST request:" + album.toJsonString());
}
