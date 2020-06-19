import ballerina/test;
import ballerina/http;
import ballerina/runtime;

string serviceReply = "";
string msg = "hey";

@test:Config {}
function testText() {
    http:WebSocketClient wsClient = new("ws://localhost:9090/proxy/ws", {callbackService:callback});
    checkpanic wsClient->pushText(msg);
    runtime:sleep(4000);
    test:assertEquals(serviceReply, msg, "Received message should be equal to the expected message");
}

service callback = @http:WebSocketServiceConfig {} service {
    resource function onText(http:WebSocketClient conn, string text, boolean finalFrame) {
        serviceReply = <@untainted>text;
    }
};
