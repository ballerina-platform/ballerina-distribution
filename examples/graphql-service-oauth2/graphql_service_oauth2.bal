import ballerina/graphql;

type Profile record {|
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

// The service can be secured with OAuth2 and by enforcing authorization optionally. It can be
// enabled by setting the `graphql:OAuth2IntrospectionConfig` configurations. Authorization is
// based on scopes. A scope maps to one or more groups. Authorization can be enabled by setting the
// `string|string[]` type configurations for the `scopes` field.
@graphql:ServiceConfig {
    auth: [
        {
            oauth2IntrospectionConfig: {
                url: "https://localhost:9445/oauth2/introspect",
                tokenTypeHint: "access_token",
                scopeKey: "scp",
                clientConfig: {
                    customHeaders: {"Authorization": "Basic YWRtaW46YWRtaW4="},
                    secureSocket: {
                        cert: "../resource/path/to/public.crt"
                    }
                }
            },
            scopes: ["admin"]
        }
    ]
}
service /graphql on securedEP {
    resource function get profile() returns Profile {
        return {
            name: "Walter White",
            age: 50
        };
    }
}
