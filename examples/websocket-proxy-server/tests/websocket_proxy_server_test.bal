import ballerina/test;
import ballerina/websocket;
import ballerina/lang.runtime;

string serviceReply = "";
string msg = "hey";

@test:Config {}
function testText() {
    websocket:AsyncClient wsClient = new("ws://localhost:9090/proxy/ws", new callback());
    checkpanic wsClient->writeTextMessage(msg);
    runtime:sleep(4);
    test:assertEquals(serviceReply, msg, "Received message should be equal to the expected message");
}

service class callback{
    *websocket:Service;
    remote function onTextMessage(websocket:Caller conn, string text) {
        serviceReply = <@untainted>text;
    }
}
