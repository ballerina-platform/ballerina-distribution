import ballerina/http;
import ballerina/io;

public function main() returns @tainted error? {
    // Create an HTTP client to interact with a remote endpoint.
    http:Client clientEP = check new ("http://www.mocky.io");
    // Send a GET request to the server and expect a text payload.
    string payload = <string> check
        clientEP->get("/v2/5ae082123200006b00510c3d/", targetType = string);
    // Log the retrieved text payload.
    io:println(payload);
}
