import ballerina/test;
import ballerina/http;
import ballerina/lang.runtime;

string serviceReply = "";
string msg = "hey";

@test:Config {
}
function testText() {
    http:WebSocketClient wsClient = new("ws://localhost:9090/chat/bruce?age=30", {callbackService:callback});
    runtime:sleep(4000);
    test:assertEquals(serviceReply, "Hi bruce! You have successfully connected to the chat",
    "Received message should be equal to the expected message");
    checkpanic wsClient->pushText(msg);
    runtime:sleep(4000);
    test:assertEquals(serviceReply, "bruce: " + msg, "Received message should be equal to the expected message");
}

service callback = @http:WebSocketServiceConfig {} service {
    resource function onText(http:WebSocketClient conn, string text, boolean finalFrame) {
        serviceReply = <@untainted>text;
    }
};
