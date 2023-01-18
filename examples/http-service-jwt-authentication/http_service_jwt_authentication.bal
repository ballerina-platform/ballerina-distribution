import ballerina/http;

type Album readonly & record {|
    string title;
    string artist;
|};

listener http:Listener securedEP = new (9090,
    secureSocket = {
        key: {
            certFile: "../resource/path/to/public.crt",
            keyFile: "../resource/path/to/private.key"
        }
    }
);

// The service can be secured with JWT authentication and can be authorized optionally.
// JWT authentication can be enabled by setting the `http:JwtValidatorConfig` configurations.
// Authorization is based on scopes. A scope maps to one or more groups.
// Authorization can be enabled by setting the `string|string[]` type configurations for the `scopes` field.
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
service / on securedEP {

    // It is optional to override the authentication and authorization configurations at the resource levels.
    // Otherwise, the service auth configurations are applied automatically to the resources as well.
    resource function get albums() returns Album[] {
        return [
            {title: "Blue Train", artist: "John Coltrane"},
            {title: "Jeru", artist: "Gerry Mulligan"}
        ];
    }
}
