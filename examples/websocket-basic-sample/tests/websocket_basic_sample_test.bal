import ballerina/test;
import ballerina/log;
import ballerina/runtime;
import ballerina/websocket;

string serviceReply = "";
string msg = "hey";

@test:Config {}
function testText() {
    websocket:Client wsClient = new("ws://localhost:9090/basic/ws", {callbackService:callback,
    subProtocols:["xml", "my-protocol"]});
    websocket:WebSocketError? result = wsClient->pushText(msg);
    if (result is websocket:WebSocketError) {
        log:printError("Error occurred when pushing text", err = result);
    }
    runtime:sleep(4000);
    test:assertEquals(serviceReply, "You said: " + msg, "Received message should be equal to the expected message");
}

service object {} callback = @websocket:ServiceConfig {} service object {
    resource function onText(websocket:Client conn, string text, boolean finalFrame) {
        serviceReply = <@untainted>text;
    }
};
