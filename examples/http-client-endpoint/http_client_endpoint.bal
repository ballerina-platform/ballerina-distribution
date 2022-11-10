import ballerina/http;
import ballerina/io;

public function main() returns error? {
    // Creates a new client with the backend URL.
    final http:Client httpClient = check new ("postman-echo.com");

    // Sends a `GET` request to the "/headers" resource.
    // The verb is not mandatory as it is default to "GET".
    io:println("GET request:");
    json resp = check httpClient->/headers;
    io:println(resp.toJsonString());

    // above call can be executed as follows using remote methods too.
    resp = check httpClient->get("/headers");

    // Sends a `POST` request to the "/post" resource.
    io:println("\nPOST request:");
    resp = check httpClient->/post.post("Hello World");
    io:println(resp.toJsonString());
}
