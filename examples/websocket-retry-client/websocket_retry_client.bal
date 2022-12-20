import ballerina/websocket;

public function main() returns error? {
    websocket:Client chatRetryClient = check new ("ws://localhost:9090/chat", {
        // Set the maximum retry count to 5 so that it will try 5 times with the interval of
        // 5 second in between the retry attempts.
        retryConfig: {
            maxCount: 5,
            interval: 5
        }
    });
    check chatRetryClient->writeMessage("Hey Sam!");
}
