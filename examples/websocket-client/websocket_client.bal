import ballerina/io;
import ballerina/websocket;

public function main() returns error? {
   // Create a new [WebSocket client](https://lib.ballerina.io/ballerina/websocket/latest/clients/Client).
   websocket:Client echoClient = check new("ws://localhost:9090/echo");

   // Write a message to the server using [`writeMessage`](https://lib.ballerina.io/ballerina/websocket/latest/clients/Client#writeMessage).
   // This function accepts `anydata`. If the given type is a `byte[]`, the message will be sent as binary frames and 
   // the rest of the data types will be sent as text frames.
   // For more information on data binding, see the [spec](https://github.com/ballerina-platform/module-ballerina-websocket/blob/main/docs/proposals/data-binding-api.md)
   check echoClient->writeMessage("Hello World!");

   // Read a message echoed from the server using [`readMessage`](https://lib.ballerina.io/ballerina/websocket/latest/clients/Client#readMessage).
   // The contextually-expected data type is inferred from the LHS variable type. The received data will be converted to that particular data type.
   string message = check echoClient->readMessage();
   io:println(message);
}
