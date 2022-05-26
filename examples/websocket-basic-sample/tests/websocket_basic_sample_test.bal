import ballerina/test;
import ballerina/log;
import ballerina/websocket;

string msg = "hey";

@test:Config {}
function testText() returns websocket:Error? {
    websocket:Client wsClient = check new("ws://localhost:9090/echo");
    websocket:Error? result = wsClient->writeMessage(msg);
    if (result is websocket:Error) {
        log:printError("Error occurred when pushing text", 'error = result);
    }
    string serviceReply = check wsClient->readMessage();
    test:assertEquals(serviceReply, "You said: " + msg, "Received message should be equal to the expected message");
}

