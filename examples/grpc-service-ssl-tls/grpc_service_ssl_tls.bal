import ballerina/grpc;

// A gRPC listener can be configured to communicate through SSL/TLS as well.
// To secure a listener using SSL/TLS, the listener needs to be configured
// with a certificate file and a private key file for the listener.
// The [`grpc:ListenerSecureSocket`](https://docs.central.ballerina.io/ballerina/grpc/latest/records/ListenerSecureSocket) record
// provides the SSL-related listener configurations of the listener.
listener grpc:Listener securedEP = new(9090,
    secureSocket = {
        key: {
            certFile: "./resources/public.crt",
            keyFile: "./resources/private.key"
        }
    }
);

@grpc:ServiceDescriptor {
    descriptor: ROOT_DESCRIPTOR_GRPC_SERVICE,
    descMap: getDescriptorMapGrpcService()
}
service "HelloWorld" on securedEP {
    remote function hello() returns string {
        return "Hello, World!";
    }
}
