import ballerina/http;
import ballerina/io;

type Album readonly & record {|
    string title;
    string artist;
|};

public function main() returns error? {
    http:Client albumClient = check new ("localhost:9090");
    Album album = { title: "Sarah Vaughan and Clifford Brown", artist: "Sarah Vaughan" };
    // Create an http request object.
    http:Request httpRequest = new;
    // Set the album record as the payload of the http request.
    httpRequest.setPayload(album);

    // Send a `POST` request to the "/albums" resource.
    Album albums = check albumClient->/albums.post(httpRequest);
    io:println("POST request:" + albums.toJsonString());
}
