import ballerina/io;
import ballerina/websocket;

service /basic/ws on new websocket:Listener(9090) {
   resource isolated function get .()
                     returns websocket:Service|websocket:Error {
       // Accept the WebSocket upgrade by returning a `websocket:Service`.
       return new WsService();
   }
}

service class WsService {
    *websocket:Service;
    // This `remote function` is triggered when a new text message is received
    // from a client.
    remote isolated function onTextMessage(websocket:Caller caller,
                                 string text) returns websocket:Error? {
        io:println("\ntext message: " + text);
        return caller->writeTextMessage("You said: " + text);
    }
}
