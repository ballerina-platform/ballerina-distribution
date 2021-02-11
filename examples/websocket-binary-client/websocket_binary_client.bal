import ballerina/io;
import ballerina/lang.'string;
import ballerina/websocket;

public function main() returns error? {
    // Creates a new [WebSocket client](https://ballerina.io/learn/api-docs/ballerina/#/ballerina/websocket/latest/websocket/clients/Client).
   websocket:Client wsClient = check new("ws://echo.websocket.org");

   // Writes a binary message to the server using [writeBinaryMessage](https://ballerina.io/learn/api-docs/ballerina/#/ballerina/websocket/latest/websocket/clients/Client#writeBinaryMessage).
   check wsClient->writeBinaryMessage("Binary message".toBytes());

   // Reads a binary message echoed from the server using [readBinaryMessage](https://ballerina.io/learn/api-docs/ballerina/#/ballerina/websocket/latest/websocket/clients/Client#readBinaryMessage).
   byte[] byteResp = check wsClient->readBinaryMessage();
   string stringResp = check 'string:fromBytes(byteResp);
   io:println(stringResp);
}
