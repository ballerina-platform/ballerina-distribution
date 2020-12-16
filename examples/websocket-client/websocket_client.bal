import ballerina/websocket;
import ballerina/io;

public function main() {
    // Creates a new [WebSocket client](https://ballerina.io/swan-lake/learn/api-docs/ballerina/#/http/clients/WebSocketClient) with the backend URL and assigns a callback service.
    websocket:Client wsClientEp = new ("ws://echo.websocket.org",
                            config = {callbackService: ClientService});
    // Pushes a text message to the server using [pushText](https://ballerina.io/swan-lake/learn/api-docs/ballerina/#/http/clients/WebSocketClient#pushText).
    var err = wsClientEp->pushText("Hello World!");
    if (err is error) {
        // Prints the error.
        io:println(err);
    }
}
// The client callback service, which handles backend responses.
service object {} ClientService = @websocket:ServiceConfig {} service object {

    // This remote function is triggered when a new text frame is received from
    // the remote backend.
    remote function onText(websocket:Client conn, string text,
                             boolean finalFrame) {
        io:println(text);
    }
    // This is triggered if an error occurs.
    remote function onError(websocket:Client conn, error err) {
        io:println(err);
    }
};
