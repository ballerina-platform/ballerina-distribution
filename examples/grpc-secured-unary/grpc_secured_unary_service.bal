// This is the server implementation of the secured connection (HTTPS) scenario.
import ballerina/grpc;
import ballerina/log;

// The server endpoint configuration with the SSL configurations.
listener grpc:Listener ep = new (9090, {
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
service "HelloWorld" on ep {
    remote function hello(string request) returns string|error {
        log:printInfo("Invoked the hello RPC call.");
        // Reads the request message and sends a response.
        return "Hello " + request;
    }
}
