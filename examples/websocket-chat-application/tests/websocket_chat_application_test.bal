import ballerina/test;
import ballerina/websocket;
import ballerina/lang.runtime;

string serviceReply = "";
string msg = "hey";

@test:Config {}
function testText() returns websocket:Error? {
    websocket:AsyncClient wsClient = check new("ws://localhost:9090/chat/bruce?age=30", new callback());
    runtime:sleep(4);
    test:assertEquals(serviceReply, "Hi bruce! You have successfully connected to the chat",
    "Received message should be equal to the expected message");
    checkpanic wsClient->writeTextMessage(msg);
    runtime:sleep(4);
    test:assertEquals(serviceReply, "bruce: " + msg, "Received message should be equal to the expected message");
    error? result = wsClient->close(statusCode = 1000, timeoutInSeconds = 10);
}

service class callback {
    *websocket:Service;
    remote function onTextMessage(websocket:Caller conn, string text) {
        serviceReply = <@untainted>text;
    }
}
