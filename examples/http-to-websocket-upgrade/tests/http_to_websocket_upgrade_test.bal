import ballerina/http;
import ballerina/log;
import ballerina/test;
import ballerina/runtime;

string serviceReply = "";
string msg = "hey";
@test:Config {}
function testWebSocket() {
    http:WebSocketClient wsClient = new("ws://localhost:9090/hello/ws", config = {callbackService:callback});
    error? result = wsClient->pushText(msg);
    if (result is error) {
        log:printError("Error in sending text", result);
    }
    runtime:sleep(5000);
    test:assertEquals(serviceReply, msg, msg = "Received message should be equal to the expected message");
}

@test:Config {}
function testHttp() returns @tainted error? {
    http:Client httpClient = new("http://localhost:9090");
    http:Response resp = <http:Response> check httpClient->post("/hello/world", msg);
    test:assertEquals(check resp.getTextPayload(), "HTTP POST received: " + msg, msg = "Received message should be equal to the expected message");
}
service callback = @http:WebSocketServiceConfig {} service {
    resource function onText(http:WebSocketClient conn, string text, boolean finalFrame) {
        serviceReply = <@untainted>text;
    }
};
