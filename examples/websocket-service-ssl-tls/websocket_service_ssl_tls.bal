import ballerina/websocket;

// A WebSocket listener can be configured to communicate through WSS as well.
// To secure a listener using SSL/TLS, the listener needs to be configured with
// a certificate file and a private key file for the listener.
// The [`websocket:ListenerSecureSocket`](https://lib.ballerina.io/ballerina/websocket/latest/records/ListenerSecureSocket) record
// provides the SSL-related listener configurations of the listener.
listener websocket:Listener securedEP = new(9090,
    secureSocket = {
        key: {
            certFile: "../resource/path/to/public.crt",
            keyFile: "../resource/path/to/private.key"
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
