import ballerina/websocket;

public function main() returns error? {
    websocket:Client wsClient = check new("ws://localhost:9090/echo", {
        // Set the maximum retry count to 5 so that it will try 5 times with the interval of
        // 5 second in between the retry attempts.
        retryConfig: {
            maxCount: 5,
            interval: 5
        }
    });
    check wsClient->writeMessage("Hey Sam!");
}
