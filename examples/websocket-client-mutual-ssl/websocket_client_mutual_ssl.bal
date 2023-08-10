import ballerina/io;
import ballerina/websocket;

public function main() returns error? {
    // A WebSocket client can be configured to initiate new connections that are
    // secured via mutual SSL.
    // The `websocket:ClientSecureSocket` record provides the SSL-related configurations.
    websocket:Client chatClient = check new ("wss://localhost:9090/chat",
        secureSocket = {
            key: {
                certFile: "../resource/path/to/public.crt",
                keyFile: "../resource/path/to/private.key"
            },
            cert: "../resource/path/to/public.crt"
        }
    );
    check chatClient->writeMessage("Hello, John!");
    string chatMessage = check chatClient->readMessage();
    io:println(chatMessage);
}
