import ballerina/grpc;

// A gRPC listener can be configured to communicate through SSL/TLS as well.
// To secure a listener using SSL/TLS, the listener needs to be configured
// with a certificate file and a private key file for the listener.
// The `grpc:ListenerSecureSocket` record provides the SSL-related listener configurations of the listener.
listener grpc:Listener securedEP = new (9090,
    secureSocket = {
        key: {
            certFile: "./resources/public.crt",
            keyFile: "./resources/private.key"
        }
    }
);

@grpc:Descriptor {
    value: GRPC_SIMPLE_DESC
}
service "HelloWorld" on securedEP {
    remote function hello(string request) returns string {
        return "Hello " + request;
    }
}
