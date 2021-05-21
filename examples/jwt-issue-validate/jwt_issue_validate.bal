import ballerina/io;
import ballerina/jwt;

public function main() returns error? {
    // Defines the JWT issuer configurations with the private key file configurations which is used to self-sign the JWT.
    jwt:IssuerConfig issuerConfig = {
        username: "ballerina",
        issuer: "wso2",
        audience: "vEwzbcasJVQm1jVYHUHCjhxZ4tYa",
        keyId: "NTAxZmMxNDMyZDg3MTU1ZGM0MzEzODJhZWI4NDNlZDU1OGFkNjFiMQ",
        expTime: 3600,
        // Signature can be created using either private key configurations or keystore configuration.
        // [jwt:IssuerSignatureConfig](https://docs.central.ballerina.io/ballerina/jwt/latest/records/IssuerSignatureConfig)
        signatureConfig: {
            config: {
                keyFile: "../resource/path/to/private.key"
            }
        }
    };

    // Issues a JWT based on the provided header, payload, and private key.
    string jwt = check jwt:issue(issuerConfig);
    io:println("Issued JWT: ", jwt);

    // Defines the JWT validator configurations with the public certificate file configurations which is used to
    // validated the signature of JWT.
    jwt:ValidatorConfig validatorConfig = {
        issuer: "wso2",
        audience: "vEwzbcasJVQm1jVYHUHCjhxZ4tYa",
        clockSkew: 60,
        // Signature can be validated using public certificate file or truststore configurations or JWKS configurations.
        // [jwt:ValidatorSignatureConfig](https://docs.central.ballerina.io/ballerina/jwt/latest/records/ValidatorSignatureConfig)
        signatureConfig: {
            certFile: "../resource/path/to/public.crt"
        }
    };

    // Validates the created JWT.
    jwt:Payload payload = check jwt:validate(jwt, validatorConfig);
    io:println("Validated JWT Payload: ", payload.toString());
}
