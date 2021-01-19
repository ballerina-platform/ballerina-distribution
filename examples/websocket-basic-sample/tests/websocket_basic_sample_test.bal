import ballerina/test;
import ballerina/log;
import ballerina/lang.runtime as runtime;
import ballerina/websocket;

string serviceReply = "";
string msg = "hey";

@test:Config {}
function testText() returns websocket:Error? {
    websocket:AsyncClient wsClient = check new("ws://localhost:9090/basic/ws", new callback(),
    {subProtocols:["xml", "my-protocol"]});
    websocket:Error? result = wsClient->writeTextMessage(msg);
    if (result is websocket:Error) {
        log:printError("Error occurred when pushing text", err = result);
    }
    runtime:sleep(4);
    test:assertEquals(serviceReply, "You said: " + msg, "Received message should be equal to the expected message");
}

service class callback {
    *websocket:Service;
    remote function onTextMessage(websocket:Caller conn, string text) {
        serviceReply = <@untainted>text;
    }
}
