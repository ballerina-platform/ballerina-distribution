import ballerina/constraint;
import ballerina/io;
import ballerina/websocket;

// Add a constraint for the maximum length.
@constraint:String {
    maxLength: 20
}
public type Chat string;

service /chat on new websocket:Listener(9090) {

    resource function get .() returns websocket:Service {
        return new ChatService();
    }
}

service class ChatService {
    *websocket:Service;

    remote function onMessage(websocket:Caller caller, Chat chatMessage) returns error? {
        io:println(chatMessage);
        check caller->writeMessage("Hello!, How are you?");
    }
}
