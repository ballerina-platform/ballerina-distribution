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
        },
        // Optional config which enables the preferred SSL protocol and its versions.
        protocol: {
            name: http:TLS,
            versions: ["TLSv1.2", "TLSv1.1"]
        },
        // Optional config which configures the preferred ciphers.
        ciphers: ["TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA"]

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
