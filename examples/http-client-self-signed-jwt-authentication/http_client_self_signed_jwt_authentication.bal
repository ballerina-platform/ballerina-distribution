import ballerina/http;
import ballerina/io;

type Album readonly & record {
    string title;
    string artist;
};

public function main() returns error? {
    // Defines the HTTP client to call the JWT Auth secured APIs.
    // The client is enriched with the `Authorization: Bearer <token>` header by
    // passing the `http:JwtIssuerConfig` for the `auth` configuration of the
    // client. A self-signed JWT is issued before the request is sent.
    http:Client albumClient = check new ("localhost:9090",
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
    Album[] payload = check albumClient->/albums;
    io:println(payload);
}
