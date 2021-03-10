import ballerina/http;

listener http:Listener securedEP = new(9090, config = {
    secureSocket: {
        key: {
            certFile: "../resource/path/to/public.crt",
            keyFile: "../resource/path/to/private.key"
        }
    }
});

// The service can be secured with Basic auth and can be authorized optionally.
// Using Basic auth with the file user store can be enabled by setting the
// `http:FileUserStoreConfig` configurations.
// Authorization is based on scopes. A scope maps to one or more groups.
// Authorization can be enabled by setting the `string|string[]` type
// configurations.
@http:ServiceConfig {
    auth: [
        {
            fileUserStoreConfig: {},
            scopes: ["hello"]
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
