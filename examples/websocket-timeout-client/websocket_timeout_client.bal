import ballerina/websocket;

public function main() returns error? {
   // Set the handshake timeout for 5 seconds.
   websocket:Client chatClient = check new("ws://localhost:9090/chat", handShakeTimeout = 5);
   check chatClient->writeMessage("Hello John!");
}
