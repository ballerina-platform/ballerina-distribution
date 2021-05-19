import ballerina/io;
import ballerina/jwt;

public function main() returns error? {
    jwt:IssuerConfig issuerConfig = {
        username: "ballerina",
        issuer: "wso2",
        audience: "vEwzbcasJVQm1jVYHUHCjhxZ4tYa",
        keyId: "NTAxZmMxNDMyZDg3MTU1ZGM0MzEzODJhZWI4NDNlZDU1OGFkNjFiMQ",
        expTime: 3600,
        signatureConfig: {
            config: {
                keyFile: "../resource/path/to/private.key"
            }
        }
    };

    // Issues a JWT based on the provided header, payload, and private key.
    string jwt = check jwt:issue(issuerConfig);
    io:println("Issued JWT: ", jwt);

    // Defines the JWT validator configurations with the certificate file configurations.
    jwt:ValidatorConfig validatorConfig1 = {
        issuer: "wso2",
        audience: "vEwzbcasJVQm1jVYHUHCjhxZ4tYa",
        clockSkew: 60,
        signatureConfig: {
            certFile: "../resource/path/to/public.crt"
        }
    };

    // Validates the created JWT. The signature is validated using the public certificate.
    jwt:Payload payload1 = check jwt:validate(jwt, validatorConfig1);
    io:println("Validated JWT Payload: ", payload1.toString());

    // Defines the JWT validator configurations with the JWKs configurations.
    jwt:ValidatorConfig validatorConfig2 = {
        issuer: "wso2",
        audience: "vEwzbcasJVQm1jVYHUHCjhxZ4tYa",
        clockSkew: 60,
        signatureConfig: {
            jwksConfig: {
                url: "https://localhost:20000/oauth2/jwks",
                clientConfig: {
                    secureSocket: {
                        cert: "../resource/path/to/public.crt"
                    }
                }
            }
        }
    };

    // Validates the created JWT. The signature is validated using the JWKs endpoint.
    jwt:Payload payload2 = check jwt:validate(jwt, validatorConfig2);
    io:println("Validated JWT Payload: ", payload2.toString());
}
