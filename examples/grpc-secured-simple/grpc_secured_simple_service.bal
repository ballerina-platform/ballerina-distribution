// This is the server implementation of the secured connection (HTTPS) scenario.
import ballerina/grpc;

// Creates a gRPC Listener endpoint with TLS enabled.
listener grpc:Listener securedEp = new (9090, {
    host: "localhost",
    secureSocket: {
        key: {
            certFile: "../resource/path/to/public.crt",
            keyFile: "../resource/path/to/private.key"
        }
    }
});

@grpc:ServiceDescriptor {
    descriptor: ROOT_DESCRIPTOR,
    descMap: getDescriptorMap()
}
service "HelloWorld" on securedEp {
    remote function hello(string request) returns string|error {
        // Reads the request message and sends a response.
        return "Hello " + request;
    }
}
