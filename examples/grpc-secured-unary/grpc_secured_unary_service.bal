// This is the server implementation for the secured connection (HTTPS) scenario.
import ballerina/config;
import ballerina/grpc;
import ballerina/log;

// Server endpoint configuration with the SSL configurations.
listener grpc:Listener ep = new (9090, {
    host: "localhost",
    secureSocket: {
        keyStore: {
            path: config:getAsString("b7a.home") +
                  "/bre/security/ballerinaKeystore.p12",
            password: "ballerina"
        }
    }
});

@grpc:ServiceDescriptor {
    descriptor: ROOT_DESCRIPTOR,
    descMap: getDescriptorMap()
}
service /HelloWorld on ep {
    isolated remote function hello(grpc:Caller caller, string name) {
        log:print("Server received hello from " + name);
        string message = "Hello " + name;

        // Send a response message to the caller.
        grpc:Error? err = caller->send(message);

        if (err is grpc:Error) {
            log:printError("Error from Connector: " + err.message());
        } else {
            log:print("Server send response : " + message);
        }

        // Send the `completed` notification to the caller.
        grpc:Error? result = caller->complete();
        if (result is grpc:Error) {
            log:printError("Error in sending completed notification to caller",
                err = result);
        }
    }
}
