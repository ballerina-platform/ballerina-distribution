import ballerina/http;
import ballerina/websocket;

// A WebSocket listener can be configured to accept new connections that are
// secured via mutual SSL.
// The `websocket:ListenerSecureSocket` record provides the SSL-related listener configurations.
// For details, see https://lib.ballerina.io/ballerina/websocket/latest/records/ListenerSecureSocket.
listener websocket:Listener securedEP = new(9090,
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

service /foo on securedEP {
    resource function get bar() returns websocket:Service {
        return new WsService();
   }
}

service class WsService {
    *websocket:Service;
    remote function onMessage(websocket:Caller caller,
                             string text) returns websocket:Error? {
        check caller->writeMessage(text);
    }
}
