import ballerina/test;
import ballerina/http;
import ballerina/log;
import ballerina/runtime;

string serviceReply = "";
string msg = "hey";

@test:Config {}
function testText() {
    http:WebSocketClient wsClient = new("ws://localhost:9090/basic/ws", {callbackService:callback,
    subProtocols:["xml", "my-protocol"]});
    http:WebSocketError? result = wsClient->pushText(msg);
    if (result is http:WebSocketError) {
        log:printError("Error occurred when pushing text", <error> result);
    }
     runtime:sleep(4000);
    test:assertEquals(serviceReply, "You said: " + msg, "Received message should be equal to the expected message");
}

service callback = @http:WebSocketServiceConfig {} service {
    resource function onText(http:WebSocketClient conn, string text, boolean finalFrame) {
        serviceReply = <@untainted>text;
    }
};
