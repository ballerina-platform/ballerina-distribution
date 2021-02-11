import ballerina/io;
import ballerina/jwt;

public function main() {
    jwt:IssuerConfig issuerConfig = {
        username: "admin",
        issuer: "ballerina",
        audience: "vEwzbcasJVQm1jVYHUHCjhxZ4tYa",
        keyId: "NTAxZmMxNDMyZDg3MTU1ZGM0MzEzODJhZWI4NDNlZDU1OGFkNjFiMQ",
        expTimeInSeconds: 3600,
        signatureConfig: {
            config: {
                keyStore: {
                    path: "../resources/ballerinaKeystore.p12",
                    password: "ballerina"
                },
                keyAlias: "ballerina",
                keyPassword: "ballerina"
            }
        }
    };

    // Issues a JWT based on the provided header, payload, and keystore config.
    string|jwt:Error jwt = jwt:issue(issuerConfig);
    if (jwt is string) {
        io:println("Issued JWT: ", jwt);
    } else {
        io:println("An error occurred while issuing the JWT: ",
            jwt.message());
    }

    // Defines the JWT validator configurations with truststore configurations.
    jwt:ValidatorConfig validatorConfig1 = {
        issuer: "ballerina",
        audience: "vEwzbcasJVQm1jVYHUHCjhxZ4tYa",
        clockSkewInSeconds: 60,
        signatureConfig: {
            trustStoreConfig: {
                certAlias: "ballerina",
                trustStore: {
                    path: "../resources/ballerinaTruststore.p12",
                    password: "ballerina"
                }
            }
        }
    };

    // Validates the created JWT. Signature is validated using the truststore.
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
        issuer: "ballerina",
        audience: "vEwzbcasJVQm1jVYHUHCjhxZ4tYa",
        clockSkewInSeconds: 60,
        signatureConfig: {
            jwksConfig: {
                url: "https://localhost:20000/oauth2/jwks",
                clientConfig: {
                    secureSocket: {
                        trustStore: {
                            path: "../resources/ballerinaTruststore.p12",
                            password: "ballerina"
                        }
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
