import ballerina/http;
import ballerina/websocket;

// A WebSocket listener can be configured to accept new connections that are
// secured via mutual SSL.
// The `websocket:ListenerSecureSocket` record provides the SSL-related listener configurations.
listener websocket:Listener chatListener = new (9090,
    secureSocket = {
        key: {
            certFile: "../resource/path/to/public.crt",
            keyFile: "../resource/path/to/private.key"
        },
        // Enables mutual SSL.
        mutualSsl: {
            verifyClient: http:REQUIRE,
            cert: "../resource/path/to/public.crt"
        }
    }
);

service /chat on chatListener {

    resource function get .() returns websocket:Service {
        return new ChatService();
    }
}

service class ChatService {
    *websocket:Service;

    remote function onMessage(websocket:Caller caller, string chatMessage) returns websocket:Error? {
        check caller->writeMessage("Hello, How are you?");
    }
}
