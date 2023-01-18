import ballerina/http;
import ballerina/io;
import ballerina/websocket;

service /chat on new websocket:Listener(9090) {

    resource function get .(@http:Header string origin) returns websocket:Service|error {
        if origin != "http://localhost:9090" {
            // Cancel the handshake by returning an error.
            return error ("Origin not allowed");
        }
        // Accept the WebSocket upgrade by returning a `websocket:Service`.
        return new ChatService();
    }
}

service class ChatService {
    *websocket:Service;

    remote function onMessage(websocket:Caller caller, string chatMessage) returns error? {
        io:println(chatMessage);
        // If an error occurs, the error is returned from the `onMessage`. It is printed on the
        // server terminal along with the stack trace.
        check caller->writeMessage("Hello!, How are you?");
    }
}
