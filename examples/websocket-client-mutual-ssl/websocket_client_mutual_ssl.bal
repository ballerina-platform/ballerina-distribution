import ballerina/http;
import ballerina/io;
import ballerina/websocket;

// A WebSocket client can be configured to initiate new connections that are
// secured via mutual SSL.
// The [`websocket:ClientSecureSocket`](https://docs.central.ballerina.io/ballerina/websocket/latest/records/ClientSecureSocket) record provides the SSL-related configurations.
websocket:Client securedEP = check new("wss://localhost:9090/foo/bar",
    secureSocket = {
        key: {
            certFile: "../resource/path/to/public.crt",
            keyFile: "../resource/path/to/private.key"
        },
        cert: "../resource/path/to/public.crt",
        protocol: {
            name: http:TLS
        },
        ciphers: ["TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA"]

    }
);

public function main() returns error? {
    check securedEP->writeTextMessage("Hello, World!");
    string textMessage = check securedEP->readTextMessage();
    io:println(textMessage);
}
