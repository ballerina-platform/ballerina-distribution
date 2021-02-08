import ballerina/io;
import ballerina/lang.'string;
import ballerina/websocket;

public function main() returns websocket:Error? {
    // Creates a new [WebSocket client](https://ballerina.io/swan-lake/learn/api-docs/ballerina/#/ballerina/websocket/latest/websocket/clients/Client).
   websocket:Client wsClient = check new("ws://echo.websocket.org");

   // Writes a text message to the server using [writeTextMessage](https://ballerina.io/swan-lake/learn/api-docs/ballerina/#/ballerina/websocket/latest/websocket/clients/Client#writeTextMessage).
   check wsClient->writeTextMessage("Text message");

   // Reads a text message echoed from the server using [readTextMessage](https://ballerina.io/swan-lake/learn/api-docs/ballerina/#/ballerina/websocket/latest/websocket/clients/Client#readTextMessage).
   string textResp = check wsClient->readTextMessage();
   io:println(textResp);

   // Writes a binary message to the server using [writeBinaryMessage](https://ballerina.io/swan-lake/learn/api-docs/ballerina/#/ballerina/websocket/latest/websocket/clients/Client#writeBinaryMessage).
   check wsClient->writeBinaryMessage("Binary message".toBytes());

   // Reads a binary message echoed from the server using [readBinaryMessage](https://ballerina.io/swan-lake/learn/api-docs/ballerina/#/ballerina/websocket/latest/websocket/clients/Client#readBinaryMessage).
   byte[] byteResp = check wsClient->readBinaryMessage();
   string|error stringResp = 'string:fromBytes(byteResp);
   if (stringResp is string) {
       io:println(stringResp);
   }
}
