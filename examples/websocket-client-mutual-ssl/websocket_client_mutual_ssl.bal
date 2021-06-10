import ballerina/http;
import ballerina/io;
import ballerina/websocket;

public function main() returns error? {
    // An WebSocket client can be configured to initiate new connections that are
    // secured via mutual SSL.
    // The [`websocket:ClientSecureSocket`](https://docs.central.ballerina.io/ballerina/websocket/latest/records/ClientSecureSocket) record provides the SSL-related configurations.
    websocket:Client mTlsClient = check new("wss://localhost:9090/wss",
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
    check mTlsClient->writeTextMessage("Hello");
    string textMessage = check mTlsClient->readTextMessage();
    io:println(textMessage);
}
