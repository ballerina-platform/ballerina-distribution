import ballerina/io;
import ballerina/log;
import ballerina/websocket;

@websocket:ServiceConfig {
    subProtocols: ["xml", "json"],
    idleTimeout: 120
}
service /basic/ws on new websocket:Listener(9090) {
   resource isolated function get .()
                     returns websocket:Service|websocket:UpgradeError {
       // Accept the WebSocket upgrade by returning a `websocket:Service`.
       return new WsService();
   }
}

service class WsService {
    *websocket:Service;
    // This `remote function` is triggered when a new text message is received
    // from a client.
    remote isolated function onTextMessage(websocket:Caller caller,
                                 string text) {
        io:println("\ntext message: " + text);
        websocket:Error? err = caller->writeTextMessage("You said: " + text);
        if err is websocket:Error {
            log:printError("Error occurred when sending text", 'error = err);
        }
    }
}
