import ballerina/http;
import ballerina/io;

public function main() returns error? {
    // Creates a new client with the backend URL.
    final http:Client clientEndpoint = 
                        check new ("http://postman-echo.com");
    
    // Sends a `GET` request to the specified endpoint.
    io:println("GET request:");
    json resp = check clientEndpoint->get("/get?test=123");
    io:println(resp.toJsonString());

    // The `get()`, `head()`, and `options()` have the optional headers parameter to send out headers,
    io:println("\nGET request with Headers:");
    resp = check clientEndpoint->get("/get",
            {"Sample-Name": "http-client-connector"});
    io:println(resp.toJsonString());

    // Sends a `POST` request to the specified endpoint.
    io:println("\nPOST request:");
    resp = check clientEndpoint->post("/post", "POST: Hello World");
    io:println(resp.toJsonString());

    // Uses the `execute()` remote function for custom HTTP verbs.
    io:println("\nUse custom HTTP verbs:");
    http:Response response = check clientEndpoint->execute(
                        "COPY", "/get", "CUSTOM: Hello World");

    io:println("Status code: " + response.statusCode.toString());
}
