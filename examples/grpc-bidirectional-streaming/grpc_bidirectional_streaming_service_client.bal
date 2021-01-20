// This is client implementation for bidirectional streaming scenario.
import ballerina/grpc;
import ballerina/io;
import ballerina/lang.runtime;

int total = 0;
public function main() {

    //Client endpoint configuration.
    ChatClient chatEp = new ("http://localhost:9090");

    grpc:StreamingClient ep;
    // Executes unary non-blocking call registering server message listener.
    var res = chatEp->chat(ChatMessageListener);

    if (res is grpc:Error) {
        io:println("Error from Connector: " + res.message());
        return;
    } else {
        io:println("Initialized connection sucessfully.");
        ep = res;
    }

    // Sends multiple messages to the server.
    ChatMessage mes = {name: "Sam", message: "Hi "};
    grpc:Error? connErr = ep->send(mes);

    if (connErr is grpc:Error) {
        io:println("Error from Connector: " + connErr.message());
    }
    runtime:sleep(6000);

    // Once all messages are sent, client send complete message to notify the server, I’m done.
    grpc:Error? result = ep->complete();
    if (result is grpc:Error) {
        io:println("Error in sending complete message", result);
    }
}


service object{} ChatMessageListener = service object {

    // Resource registered to receive server messages.
    function onMessage(string message) {
        io:println("Response received from server: " + message);
    }

    // Resource registered to receive server error messages.
    function onError(error err) {
        io:println("Error reported from server: " + err.message());
    }

    // Resource registered to receive server completed message.
    function onComplete() {
        io:println("Server Complete Sending Responses.");
    }
};
