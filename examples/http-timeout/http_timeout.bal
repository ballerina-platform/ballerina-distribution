import ballerina/http;
import ballerina/lang.runtime;

final http:Client backendClientEP = check new ("http://localhost:8080", {
    // Timeout configuration.
    timeout: 10
});

// Create an HTTP service bound to the listener endpoint.
service / on new http:Listener(9090) {

    resource function get timeout() returns string|http:InternalServerError {
        string|error response = backendClientEP->get("/hello");

        // If `response` is a `string` (text/plain), it is sent back to the
        // client. If `response` is an `http:ClientError`, an internal
        // server error is returned to the client.
        if (response is string) {
            return response;
        } else {
            if (response is http:IdleTimeoutError) {
                return { body: 
                "Request timed out. Please try again in sometime."};
            } else {
                return { body: response.message()};
            }
        }

    }
}

// This sample service is used to mock connection timeouts.
service / on new http:Listener(8080) {

    resource function get hello() returns string {
        // Delay the response by 15 seconds to mimic the network level delays.
        runtime:sleep(15);
        return "Hello World!!!";
    }
}
