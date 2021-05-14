import ballerina/io;
import ballerina/jwt;

public function main() {
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
    string|jwt:Error jwt = jwt:issue(issuerConfig);
    if (jwt is string) {
        io:println("Issued JWT: ", jwt);
    } else {
        io:println("An error occurred while issuing the JWT: ",
            jwt.message());
    }

    // Defines the JWT validator configurations with certificate file configurations.
    jwt:ValidatorConfig validatorConfig1 = {
        issuer: "wso2",
        audience: "vEwzbcasJVQm1jVYHUHCjhxZ4tYa",
        clockSkew: 60,
        signatureConfig: {
            certFile: "../resource/path/to/public.crt"
        }
    };

    // Validates the created JWT. Signature is validated using the public certificate.
    jwt:Payload|jwt:Error result = jwt:validate(checkpanic jwt,
                                                validatorConfig1);
    if (result is jwt:Payload) {
        io:println("Validated JWT Payload: ", result.toString());
    } else {
        io:println("An error occurred while validating the JWT: ",
            result.message());
    }

    // Defines the JWT validator configurations with JWKs configurations.
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

    // Validates the created JWT. Signature is validated using the JWKs endpoint.
    result = jwt:validate(checkpanic jwt, validatorConfig2);
    if (result is jwt:Payload) {
        io:println("Validated JWT Payload: ", result.toString());
    } else {
        io:println("An error occurred while validating the JWT: ",
            result.message());
    }
}
