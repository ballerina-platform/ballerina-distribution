// This is the server implementation for the unary blocking/unblocking scenario.
import ballerina/grpc;
import ballerina/log;

listener grpc:Listener ep = new (9090);

@grpc:ServiceDescriptor {
    descriptor: ROOT_DESCRIPTOR,
    descMap: getDescriptorMap()
}
service "HelloWorld" on ep {
    remote function hello(HelloWorldStringCaller caller, ContextString request) {
        log:print("Invoked the hello RPC call.");
        // Reads the request content 
        string message = "Hello " + request.content;
        // Reads the custom headers in the request request.headers.hasKey
        string reqHeader = request.headers.hasKey("client_header_key")? <string>request.headers.get("client_header_key"):"none";
        log:print("Server received header value: " + reqHeader);
        // Writes custom headers to response message.
        map<string|string[]> responseHeaders = {};
        responseHeaders["server_header_key"] = ["Response Header value"];
        // Set up the response message and send it
        ContextString responseMessage = {content: message, headers: responseHeaders};
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
    
    isolated remote function send(string|ContextString response) returns grpc:Error? {
        return self.caller->send(response);
    }
    
    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }
}

# Context record includes message payload and headers.
public type ContextString record {|
    string content;
    map<string|string[]> headers;
|};
