import ballerina/graphql;

type Person record {|
    string name;
    int age;
|};

listener graphql:Listener securedEP = new (9090,
    secureSocket = {
        key: {
            certFile: "../resource/path/to/public.crt",
            keyFile: "../resource/path/to/private.key"
        }
    }
);

// The service can be secured with JWT Auth and can be authorized optionally. JWT Auth can be
// enabled by setting the `graphql:JwtValidatorConfig` configurations. Authorization is based on
// scopes. A scope maps to one or more groups. Authorization can be enabled by setting the
// `string|string[]` type configurations for the `scopes` field.
@graphql:ServiceConfig {
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
service /graphql on securedEP {
    resource function get profile() returns Person {
        return {
            name: "Walter White",
            age: 50
        };
    }
}
