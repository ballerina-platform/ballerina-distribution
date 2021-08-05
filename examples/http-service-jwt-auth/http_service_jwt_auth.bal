import ballerina/http;

listener http:Listener securedEP = new(9090,
    secureSocket = {
        key: {
            certFile: "../resource/path/to/public.crt",
            keyFile: "../resource/path/to/private.key"
        }
    }
);

// The service can be secured with JWT authentication and can be authorized
// optionally. JWT authentication can be enabled by setting the
// [`http:JwtValidatorConfig`](https://docs.central.ballerina.io/ballerina/http/latest/records/JwtValidatorConfig) configurations.
// Authorization is based on scopes. A scope maps to one or more groups.
// Authorization can be enabled by setting the `string|string[]` type
// configurations for `scopes` field.
@http:ServiceConfig {
    auth: [
        {
            jwtValidatorConfig: {
                issuer: "wso2",
                audience: "ballerina",
                signatureConfig: {
                    certFile: "../resource/path/to/public.crt"
                },
                scopeKey: "scp"
            },
            scopes: ["admin"]
        }
    ]
}
service /foo on securedEP {

    // It is optional to override the authentication and authorization
    // configurations at the resource levels. Otherwise, the service auth
    // configurations will be applied automatically to the resources as well.
    resource function get bar() returns string {
        return "Hello, World!";
    }
}
