import ballerina/test;
import ballerina/websocket;

@test:Config {}
function testFunc() returns error? {
    string userName = "abc";
    websocket:Client wsEndpoint = check new (string `ws://localhost:9090/chat?userName=${userName}`);
    string message = check wsEndpoint->readTextMessage();
    test:assertEquals(message, string `Welcome ${userName}!`);
    check wsEndpoint->close();
}
