import ballerina/grpc;

listener grpc:Listener securedEP = new(9090,
    secureSocket = {
        key: {
            certFile: "../resource/path/to/public.crt",
            keyFile: "../resource/path/to/private.key"
        }
    }
);

// The service can be secured with Basic Auth and can be authorized optionally.
// Using Basic Auth with the file user store can be enabled by setting the 
// `grpc:FileUserStoreConfig` configurations.
// For details, see https://lib.ballerina.io/ballerina/grpc/latest/records/FileUserStoreConfig.
// Authorization is based on scopes. A scope maps to one or more groups.
// Authorization can be enabled by setting the `string|string[]` type
// configurations for `scopes` field.
@grpc:ServiceConfig {
    auth: [
        {
            fileUserStoreConfig: {},
            scopes: ["admin"]
        }
    ]
}
@grpc:ServiceDescriptor {
    descriptor: GRPC_SERVICE_DESC
}
service "HelloWorld" on securedEP {
    remote function hello() returns string {
        return "Hello, World!";
    }
}
