// TODO: As we cannot stop the dynamic listener which is getting started
// with websocket client, this test had to be commented out.
// import ballerina/test;
// import ballerina/websocket;
// import ballerina/lang.runtime;

// string serviceReply = "";
// string msg = "hey";

// @test:Config {}
// function testText() returns websocket:Error? {
//     websocket:AsyncClient wsClient = check new("ws://localhost:9090/proxy/ws", new callback());
//     checkpanic wsClient->writeTextMessage(msg);
//     runtime:sleep(4);
//     test:assertEquals(serviceReply, msg, "Received message should be equal to the expected message");
//     error? result = wsClient->close(statusCode = 1000, timeoutInSeconds = 10);
// }

// service class callback {
//     *websocket:Service;
//     remote function onTextMessage(websocket:Caller conn, string text) {
//         serviceReply = <@untainted>text;
//     }
// }
