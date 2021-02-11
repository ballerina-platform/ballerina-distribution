import ballerina/io;
import ballerina/websocket;

public function main() returns error? {
    // Creates a new [WebSocket client](https://ballerina.io/learn/api-docs/ballerina/#/ballerina/websocket/latest/websocket/clients/Client).
   websocket:Client wsClient = check new("ws://echo.websocket.org");

   // Writes a text message to the server using [writeTextMessage](https://ballerina.io/learn/api-docs/ballerina/#/ballerina/websocket/latest/websocket/clients/Client#writeTextMessage).
   check wsClient->writeTextMessage("Text message");

   // Reads a text message echoed from the server using [readTextMessage](https://ballerina.io/learn/api-docs/ballerina/#/ballerina/websocket/latest/websocket/clients/Client#readTextMessage).
   string textResp = check wsClient->readTextMessage();
   io:println(textResp);
}
