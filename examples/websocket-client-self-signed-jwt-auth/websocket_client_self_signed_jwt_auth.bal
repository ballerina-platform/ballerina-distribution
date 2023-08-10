import ballerina/io;
import ballerina/websocket;

public function main() returns error? {
    // Defines the WebSocket client to call the JWT authentication secured APIs.
    // The client is enriched with the `Authorization: Bearer <token>` header by
    // passing the `websocket:JwtIssuerConfig` for the `auth` configuration of the
    // client. A self-signed JWT is issued before the request is sent.
    websocket:Client chatClient = check new ("wss://localhost:9090/chat",
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
    check chatClient->writeMessage("Hello, John!");
    string chatMessage = check chatClient->readMessage();
    io:println(chatMessage);
}
