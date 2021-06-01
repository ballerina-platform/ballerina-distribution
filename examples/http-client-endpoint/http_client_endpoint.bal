import ballerina/http;
import ballerina/io;

// Creates a new client with the backend URL.
final http:Client clientEndpoint = check new ("http://postman-echo.com");

public function main() {
    // Sends a `GET` request to the specified endpoint.
    io:println("GET request:");
    http:Response|error response = clientEndpoint->get("/get?test=123");
    handleResponse(response);

    // Sends a `POST` request to the specified endpoint.
    io:println("\nPOST request:");
    response = clientEndpoint->post("/post", "POST: Hello World");
    handleResponse(response);

    // Uses the `execute()` remote function for custom HTTP verbs.
    io:println("\nUse custom HTTP verbs:");
    response = clientEndpoint->execute("COPY", "/get", "CUSTOM: Hello World");

    // The `get()`, `head()`, and `options()` have the optional headers parameter to send out headers,
    response = clientEndpoint->get("/get",
                            {"Sample-Name": "http-client-connector"});

    if (response is http:Response) {
        // [Get the content type](https://docs.central.ballerina.io/ballerina/http/latest/classes/Response#getContentType) from the response.
        string contentType = response.getContentType();
        io:println("Content-Type: " + contentType);
        int statusCode = response.statusCode;
        io:println("Status code: " + statusCode.toString());
    } else {
        io:println("Error when calling the backend: ",
                            response.message());
    }
}

//The below function handles the response received from the remote HTTP endpoint.
function handleResponse(http:Response|error response) {
    if (response is http:Response) {
        var msg = response.getJsonPayload();
        if (msg is json) {
            io:println(msg.toJsonString());
        } else {
            io:println("Invalid payload received:", msg.message());
        }
    } else {
        io:println("Error when calling the backend: ",
                            response.message());
    }
}
