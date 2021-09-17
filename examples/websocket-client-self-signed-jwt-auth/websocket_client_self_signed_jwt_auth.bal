import ballerina/io;
import ballerina/websocket;

// Defines the WebSocket client to call the JWT auth secured APIs.
// The client is enriched with the `Authorization: Bearer <token>` header by
// passing the [`websocket:JwtIssuerConfig`](https://docs.central.ballerina.io/ballerina/websocket/latest/records/JwtIssuerConfig) for the `auth` configuration of the
// client. A self-signed JWT is issued before the request is sent.
websocket:Client securedEP = check new("wss://localhost:9090/foo/bar",
    auth = {
        username: "ballerina",
        issuer: "wso2",
        audience: ["ballerina", "ballerina.org", "ballerina.io"],
        keyId: "5a0b754-895f-4279-8843-b745e11a57e9",
        jwtId: "JlbmMiOiJBMTI4Q0JDLUhTMjU2In",
        customClaims: { "scp": "admin" },
        expTime: 3600,
        signatureConfig: {
            config: {
                keyFile: "../resource/path/to/private.key"
            }
        }
    },
    secureSocket = {
        cert: "../resource/path/to/public.crt"
    }
);

public function main() returns error? {
    check securedEP->writeTextMessage("Hello, World!");
    string textMessage = check securedEP->readTextMessage();
    io:println(textMessage);
}
