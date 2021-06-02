import ballerina/http;
import ballerina/log;
import ballerina/websocket;

// An WebSocket listener can be configured to accept new connections that are
// secured via mutual SSL.
// The [`websocket:ListenerSecureSocket`](https://docs.central.ballerina.io/ballerina/websocket/latest/records/ListenerSecureSocket) record provides the SSL-related listener configurations.
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
        // Enables the preferred SSL protocol and its versions.
        protocol: {
            name: http:TLS,
            versions: ["TLSv1.2", "TLSv1.1"]
        },
        // Configures the preferred ciphers.
        ciphers: ["TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA"]

    }
);

service /wss on securedEP {
   resource isolated function get .()
                     returns websocket:Service|websocket:UpgradeError {
       return new WsService();
   }
}

service class WsService {
    *websocket:Service;
    remote isolated function onTextMessage(websocket:Caller caller,
                                 string text) returns error? {
        log:printInfo("text message: " + text);
        check caller->writeTextMessage("You said: " + text);
    }
}
