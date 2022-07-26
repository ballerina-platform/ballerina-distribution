import ballerina/io;
import ballerina/websocket;

service /echo on new websocket:Listener(9090) {
   resource function get .() returns websocket:Service|websocket:Error {
       // Accept the WebSocket upgrade by returning a `websocket:Service`.
       return new WsService();
   }
}

service class WsService {
    *websocket:Service;
    // This `remote function` is triggered when a new message is received
    // from a client. It accepts `anydata` as the function argument. The received data 
    // will be converted to the data type stated as the function argument.
    // For more information on data binding, see the [spec](https://github.com/ballerina-platform/module-ballerina-websocket/blob/main/docs/proposals/data-binding-api.md)
    remote function onMessage(websocket:Caller caller, string text) returns websocket:Error? {
        io:println("\ntext message: " + text);
        return caller->writeMessage("You said: " + text);
    }
}
