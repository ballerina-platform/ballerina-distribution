import ballerina/http;
import ballerina/io;

// Defines the HTTP client to call the JWT Auth secured APIs.
// The client is enriched with the `Authorization: Bearer <token>` header by
// passing the `http:JwtIssuerConfig` for the `auth` configuration of the
// client. A self-signed JWT is issued before the request is sent.
// For details, see https://lib.ballerina.io/ballerina/http/latest/records/JwtIssuerConfig.
http:Client securedEP = check new("https://localhost:9090",
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
    string response = check securedEP->/foo/bar.get();
    io:println(response);
}
