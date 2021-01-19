import ballerina/test;
import ballerina/http;
import ballerina/lang.runtime;

string serviceReply = "";
string msg = "hey";

@test:Config {}
function testText() {
    websocket:AsyncClient wsClient = new("ws://localhost:9090/chat/bruce?age=30", new callback());
    runtime:sleep(4);
    test:assertEquals(serviceReply, "Hi bruce! You have successfully connected to the chat",
    "Received message should be equal to the expected message");
    checkpanic wsClient->writeTextMessage(msg);
    runtime:sleep(4);
    test:assertEquals(serviceReply, "bruce: " + msg, "Received message should be equal to the expected message");
}

service class callback {
    *websocket:Caller;
    remote function onTextMessage(websocket:Caller conn, string text) {
        serviceReply = <@untainted>text;
    }
}
