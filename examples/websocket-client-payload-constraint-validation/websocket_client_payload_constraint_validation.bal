import ballerina/constraint;
import ballerina/io;
import ballerina/websocket;

// Add a constraint for the maximum length.
@constraint:String {
    maxLength: 20
}
public type Chat string;

public function main() returns error? {
   websocket:Client chatClient = check new("ws://localhost:9090/chat");
   check chatClient->writeMessage("Hello John!");
   Chat message = check chatClient->readMessage();
   io:println(message);
}
