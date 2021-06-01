import ballerina/http;
import ballerina/lang.runtime;

final http:Client backendClientEP = check new ("http://localhost:8080", {
    // Timeout configuration.
    timeout: 10
});

// Create an HTTP service bound to the listener endpoint.
service /timeout on new http:Listener(9090) {

    resource function get .() returns http:InternalServerError|string|error? {
        string|error backendResponse =
                        backendClientEP->get("/hello");

        // If `backendResponse` is an `http:Response`, it is sent back to the
        // client. If `backendResponse` is an `http:ClientError`, an internal
        // server error is returned to the client.
        if (backendResponse is string) {
            return backendResponse;
        } else {
            if (backendResponse is http:IdleTimeoutError) {
                return { body: "Request timed out. Please try again in sometime."};
            } else {
                return backendResponse;
            }
        }

    }
}

// This sample service is used to mock connection timeouts.
service /hello on new http:Listener(8080) {

    resource function get .() returns string {
        // Delay the response by 15 seconds to mimic the network level delays.
        runtime:sleep(15);
        return "Hello World!!!";
    }
}
