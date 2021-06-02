import ballerina/http;
import ballerina/io;

// Creates a new client with the backend URL.
final http:Client clientEndpoint = check new ("http://postman-echo.com");

public function main() returns error? {
    // Sends a `GET` request to the specified endpoint.
    io:println("GET request:");
    json echoResponse = check clientEndpoint->get("/get?test=123");
    io:println(echoResponse.toJsonString());

    // Sends a `POST` request to the specified endpoint.
    io:println("\nPOST request:");
    json postResponse = check clientEndpoint->post("/post", "POST: Hello World");
    io:println(postResponse.toJsonString());

    // Uses the `execute()` remote function for custom HTTP verbs.
    io:println("\nUse custom HTTP verbs:");
    http:Response response = check clientEndpoint->execute("COPY", "/get", "CUSTOM: Hello World");

    // The `get()`, `head()`, and `options()` have the optional headers parameter to send out headers,
    response = check clientEndpoint->get("/get",
                            {"Sample-Name": "http-client-connector"});

    // [Get the content type](https://docs.central.ballerina.io/ballerina/http/latest/classes/Response#getContentType) from the response.
    string contentType = response.getContentType();
    io:println("Content-Type: " + contentType);
    int statusCode = response.statusCode;
    io:println("Status code: " + statusCode.toString());
}
