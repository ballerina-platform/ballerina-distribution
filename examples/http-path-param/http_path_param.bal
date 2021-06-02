import ballerina/http;

service /sample on new http:Listener(9090) {

    // The path param is defined as a part of the resource path along with the type and it is extracted from the
    // request URI.
    resource function get path/[string foo](http:Request req) returns json {
        // Create a JSON payload with the extracted value.
        json responseJson = {
            "pathParam": foo
        };
        // Send a response with the JSON payload to the client.
        return responseJson;
    }
}
