import ballerina/http;
import ballerina/io;

public function main() returns error? {
    // Creates a new client with the backend URL.
    final http:Client clientEndpoint = check new ("postman-echo.com");
    
    // Sends a `GET` request to the specified endpoint.
    io:println("GET request:");
    json resp = check clientEndpoint->/get.get(test = 123);
    io:println(resp.toJsonString());

    // Sends a `POST` request to the specified endpoint.
    io:println("\nPOST request:");
    resp = check clientEndpoint->/post.post("POST: Hello World");
    io:println(resp.toJsonString());

    io:println("Status code: " + response.statusCode.toString());
}
