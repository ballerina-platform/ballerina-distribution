// This is the server implementation for the client streaming scenario.
import ballerina/grpc;
import ballerina/io;

listener grpc:Listener ep = new (9090);

@grpc:ServiceDescriptor {
    descriptor: ROOT_DESCRIPTOR,
    descMap: getDescriptorMap()
}
service "HelloWorld" on ep {
    remote function lotsOfGreetings(stream<string,error> clientStream) returns string|error {
        io:println("connected sucessfully.");
        // Read and process each message in the client stream
        error? e = clientStream.forEach(isolated function(string name) {
            io:println("greet received: ", name);
        });
        //Once the client sends a notification to indicate the end of the stream, 'grpc:EOS' is returned by the stream
        if (e is grpc:EOS) {
            return "Ack";
        }
        return "";
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

// Context record includes message payload and headers
public type ContextString record {|
    string content;
    map<string[]> headers;
|};
