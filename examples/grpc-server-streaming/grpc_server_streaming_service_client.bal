// This is the client implementation for the server streaming scenario.
import ballerina/grpc;
import ballerina/io;

int total = 0;
public function main() {
    // Client endpoint configuration.
    HelloWorldClient helloWorldEp = new ("http://localhost:9090");

    // Execute the unary non-blocking call that registers the server message listener.
    grpc:Error? result = helloWorldEp->lotsOfReplies("Sam",
                                                    HelloWorldMessageListener);
    if (result is grpc:Error) {
        io:println("Error from Connector: " + result.message());
    } else {
        io:println("Connected successfully");
    }

    while (total == 0) {}
    io:println("Client got response successfully.");
}

// Server Message Listener.
service object{} HelloWorldMessageListener = service object {

    // The `resource` registered to receive server messages
    function onMessage(string message) {
        io:println("Response received from server: " + message);
    }

    // The `resource` registered to receive server error messages
    function onError(error err) {
        io:println("Error from Connector: " + err.message());
    }

    // The `resource` registered to receive server completed messages.
    function onComplete() {
        total = 1;
        io:println("Server Complete Sending Responses.");
    }
};
