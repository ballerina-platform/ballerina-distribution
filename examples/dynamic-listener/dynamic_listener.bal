import ballerina/http;
import ballerina/lang.runtime;
import ballerina/log;

http:Listener httpListener = new (9090);

var helloService =  service object {

    resource function get sayHello(http:Caller caller, http:Request req) {
        // Send a response back to the caller.
        var respondResult = caller->respond("Hello, World!");
        if (respondResult is error) {
            log:printError("Error occurred when responding.", 
                err = respondResult);
        }
    }

    // The resource function that will shutdown the server.
    resource function get shutDownServer(http:Caller caller, http:Request req) {
        // Send a response back to the caller.
        var respondResult = caller->respond("Shutting down the server");
        // Stop the listener.
        // This will be called automatically if the program exits by means of a system call.
        var stopResult = httpListener.gracefulStop();
        // Deregister the listener dynamically.
        runtime:deregisterListener(httpListener);
        // Handle the errors at the end.
        if (respondResult is error) {
            log:printError("Error occurred when responding.", 
                err = respondResult);
        } 
        if (stopResult is error) {
            log:printError("Error occurred when stopping the listener. ", 
                err = stopResult);
        }
    }
};

public function main() returns error? {
    // Attach the service to the listener.
    check httpListener.attach(helloService);
    // Start the listener.
    check httpListener.'start();
    // Register the listener dynamically.
    runtime:registerListener(httpListener);
}
