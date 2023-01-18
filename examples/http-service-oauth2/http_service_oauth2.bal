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

// The service can be secured with OAuth2 and by enforcing authorization optionally.
// It can be enabled by setting the `http:OAuth2IntrospectionConfig` configurations.
// Authorization is based on scopes. A scope maps to one or more groups.
// Authorization can be enabled by setting the `string|string[]` type configurations for the `scopes` field.
@http:ServiceConfig {
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
