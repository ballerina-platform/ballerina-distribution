import ballerina/websocket;

listener websocket:Listener securedEP = new(9090,
    secureSocket = {
        key: {
            certFile: "../resource/path/to/public.crt",
            keyFile: "../resource/path/to/private.key"
        }
    }
);

// The service can be secured with OAuth2 and by enforcing authorization
// optionally. It can be enabled by setting the
// [`websocket:OAuth2IntrospectionConfig`](https://lib.ballerina.io/ballerina/websocket/latest/records/OAuth2IntrospectionConfig) configurations.
// Authorization is based on scopes. A scope maps to one or more groups.
// Authorization can be enabled by setting the `string|string[]` type
// configurations for `scopes` field.
@websocket:ServiceConfig {
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
service /foo on securedEP {
    resource function get bar() returns websocket:Service {
        return new WsService();
   }
}

service class WsService {
    *websocket:Service;
    remote function onMessage(websocket:Caller caller,
                             string text) returns websocket:Error? {
        check caller->writeMessage(text);
    }
}
