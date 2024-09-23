import ballerina/websocket;

service /chat on new websocket:Listener(9090) {

    // The `userName` parameter in the resource method is treated as a query parameter,
    // which is extracted from the request URI. For example, invoking this service with
    // the URI `ws://localhost:9090/chat?userName=xyz` passes `xyz` as the value
    // to the `userName` parameter defined in the resource method.
    resource function get .(string userName) returns websocket:Service {
        return new ChatService(userName);
    }
}

service class ChatService {
    *websocket:Service;
    private final string userName;

    function init(string userName) {
        self.userName = userName;
    }

    remote function onOpen(websocket:Caller caller) returns error? {
        check caller->writeMessage(string `Welcome ${self.userName}!`);
    }
}
