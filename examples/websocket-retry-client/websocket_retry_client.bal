import ballerina/io;
import ballerina/websocket;

public function main() returns error? {
    websocket:Client wsClient = check new("ws://localhost:9090/foo", {
        // Set the maximum retry count to 5 so that it will try 5 times with the interval of
        // 1 second in between the retry attempts.
        retryConfig: {
            maxCount: 5,
            interval: 1
        }
    });
    // Read the message sent from the server upon upgrading to a WebSocket connection.
    string text = check wsClient->readMessage();
    io:println(text);
}
