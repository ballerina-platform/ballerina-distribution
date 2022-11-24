import ballerina/websocket;

// A WebSocket listener can be configured to communicate through WSS as well.
// To secure a listener using SSL/TLS, the listener needs to be configured with
// a certificate file and a private key file for the listener.
// The `websocket:ListenerSecureSocket` record
// provides the SSL-related listener configurations of the listener.
listener websocket:Listener securedEP = new(9090,
    secureSocket = {
        key: {
            certFile: "../resource/path/to/public.crt",
            keyFile: "../resource/path/to/private.key"
        }
    }
);

service /chat on securedEP {
    resource function get .() returns websocket:Service {
        return new WsService();
   }
}

service class WsService {
    *websocket:Service;
    remote function onMessage(websocket:Caller caller, string chatMessage) returns websocket:Error? {
        check caller->writeMessage("Hello, How are you?");
    }
}
