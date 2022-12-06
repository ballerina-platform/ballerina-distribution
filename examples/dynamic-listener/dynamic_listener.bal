import ballerina/http;
import ballerina/lang.runtime;

http:Listener httpListener = check new (9090);

http:Service helloService =  service object {

    resource function get greeting() returns string {
        // Send a response back to the caller.
        return "Hello, World!";
    }

    // The resource function that will shutdown the server.
    resource function post shutdown(http:Caller caller) returns error? {
        // Send a response back to the caller.
        check caller->respond("Shutting down the server");
        // Stop the listener.
        // This will be called automatically if the program exits by means of a system call.
        check httpListener.gracefulStop();
        // Deregister the listener dynamically.
        runtime:deregisterListener(httpListener);
    }
};

public function main() returns error? {
    // Attach the service to the listener along with the resource path.
    check httpListener.attach(helloService, "foo/bar");
    // Start the listener.
    check httpListener.'start();
    // Register the listener dynamically.
    runtime:registerListener(httpListener);
}
