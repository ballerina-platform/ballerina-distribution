import ballerina/io;
import ballerina/websocket;

public function main() returns error? {
    // Create a new [WebSocket client](https://lib.ballerina.io/ballerina/websocket/latest/clients/Client).
   websocket:Client wsClient = check new("ws://echo.websocket.org");

   // Write a text message to the server using [writeTextMessage](https://lib.ballerina.io/ballerina/websocket/latest/clients/Client#writeTextMessage).
   check wsClient->writeTextMessage("Text message");

   // Read a text message echoed from the server using [readTextMessage](https://lib.ballerina.io/ballerina/websocket/latest/clients/Client#readTextMessage).
   string textResp = check wsClient->readTextMessage();
   io:println(textResp);
}
