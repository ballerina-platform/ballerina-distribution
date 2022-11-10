import ballerina/http;
import ballerina/io;

public function main() returns error? {
    // Creates a new client with the backend URL.
    final http:Client httpClient = check new ("localhost:9090");

    // Sends a `GET` request to the "/albums" resource.
    // The verb is not mandatory as it is default to "GET".
    io:println("GET request:");
    json resp = check httpClient->/albums;
    io:println(resp.toJsonString());

    // above call can be executed as follows using remote methods too.
    resp = check httpClient->get("/albums");

    // Sends a `POST` request to the "/albums" resource.
    io:println("\nPOST request:");
    resp = check httpClient->/albums.post({title: "Sarah Vaughan and Clifford Brown", artist: "Sarah Vaughan"});
    io:println(resp.toJsonString());
}
