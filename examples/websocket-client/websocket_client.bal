import ballerina/io;
import ballerina/websocket;

public function main() returns error? {
   // Create a new WebSocket client.
   websocket:Client chatClient = check new("ws://localhost:9090/chat");

   // Write a message to the server using `writeMessage`.
   // This function accepts `anydata`. If the given type is a `byte[]`, the message will be sent as
   // binary frames and the rest of the data types will be sent as text frames.
   check chatClient->writeMessage("Hello John!");

   // Read a message echoed from the server using `readMessage`.
   // The contextually-expected data type is inferred from the LHS variable type. The received data
   // will be converted to that particular data type.
   string message = check chatClient->readMessage();
   io:println(message);
}
