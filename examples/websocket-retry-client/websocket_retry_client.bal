import ballerina/io;
import ballerina/lang.runtime;
import ballerina/websocket;

public function main() returns error? {
    websocket:Client wsClient = check new("ws://localhost:9090/foo", {
        // Set the maximum retry count to 20 so that it will try 20 times with an interval of
        // 1 second in between the retry attempts.
        retryConfig: { maxCount: 20 }
    });
    // Read the message sent from the server upon upgrading to a WebSocket connection.
    string text = check wsClient->readTextMessage();
    io:println(text);
    io:println("Sleeping for 5 seconds. Please shutdown the server now.");
    runtime:sleep(5);
    io:println("Please restart the server now.");
    // Client will retry 20 times(20 seconds in time) until the server gets started.
    string retryMsg = check wsClient->readTextMessage();
    io:println(retryMsg);
}
