import ballerina/test;
import ballerina/websocket;

string msg = "hey";

@test:Config {}
function testText() returns websocket:Error? {
    websocket:Client wsClient = check new("ws://localhost:9090/echo");
    check wsClient->writeMessage(msg);
    string serviceReply = check wsClient->readMessage();
    test:assertEquals(serviceReply, "You said: " + msg, "Received message should be equal to the expected message");
}

