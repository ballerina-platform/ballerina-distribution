import ballerina/io;
import ballerina/websocket;

public function main() returns error? {
    // Defines the WebSocket client to call the JWT authentication secured APIs.
    // The client is enriched with the `Authorization: Bearer <token>` header by
    // passing the `websocket:JwtIssuerConfig` for the `auth` configuration of the
    // client. A self-signed JWT is issued before the request is sent.
    // For details, see https://lib.ballerina.io/ballerina/websocket/latest/records/JwtIssuerConfig.
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
    check securedEP->writeMessage("Hello, World!");
    string textMessage = check securedEP->readMessage();
    io:println(textMessage);
}
