// This is the server implementation of the secured connection (HTTPS) scenario.
import ballerina/grpc;
import ballerina/log;

// The server endpoint configuration with the SSL configurations.
listener grpc:Listener ep = new (9090, {
    host: "localhost",
    secureSocket: {
        keyStore: {
            path: "../resources/ballerinaKeystore.p12",
            password: "ballerina"
        }
    }
});

@grpc:ServiceDescriptor {
    descriptor: ROOT_DESCRIPTOR,
    descMap: getDescriptorMap()
}
service "HelloWorld" on ep {
    remote function hello(HelloWorldStringCaller caller,
                            ContextString request) {
        log:print("Invoked the hello RPC call.");
        // Reads the request content.
        string message = "Hello " + request.content;
        // Set up the response message and send it.
        ContextString responseMessage = {content: message, headers: {}};
        checkpanic caller->send(responseMessage);
        checkpanic caller->complete();
    }
}

public client class HelloWorldStringCaller {
    private grpc:Caller caller;

    public function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function send(string|ContextString response)
                                    returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response)
                                returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }
}

// The context record includes the message payload and headers.
public type ContextString record {|
    string content;
    map<string|string[]> headers;
|};
