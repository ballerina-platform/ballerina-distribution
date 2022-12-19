import ballerina/grpc;

listener grpc:Listener securedEP = new(9090,
    secureSocket = {
        key: {
            certFile: "../resource/path/to/public.crt",
            keyFile: "../resource/path/to/private.key"
        }
    }
);

// Basic authentication with the file user store can be enabled by setting
// the `grpc:FileUserStoreConfig` configuration.
// Authorization is based on scopes, which can be specified in the `scopes` field.
@grpc:ServiceConfig {
    auth: [
        {
            fileUserStoreConfig: {},
            scopes: ["admin"]
        }
    ]
}
@grpc:Descriptor {
    value: GRPC_SIMPLE_DESC
}
service "HelloWorld" on securedEP {

    remote function hello(string request) returns string {
        return "Hello " + request;
    }
}
