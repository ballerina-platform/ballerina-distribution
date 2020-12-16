// This is the server implementation for the client streaming scenario.
import ballerina/grpc;
import ballerina/log;

@grpc:ServiceDescriptor {
    descriptor: ROOT_DESCRIPTOR,
    descMap: getDescriptorMap()
}
service /HelloWorld on new grpc:Listener(9090) {

    isolated function lotsOfGreetings(grpc:Caller caller,
                            stream<string,error> clientStream) {
        log:print("Client connected successfully.");
        //Read and process each message in the client stream
        error? e = clientStream.forEach(isolated function(string name) {
            log:print("Server received greet: " + name);
        });

        //Once the client sends a notification to indicate the end of the stream, 'grpc:EOS' is returned by the stream
        if (e is grpc:EOS) {
            grpc:Error? err = caller->send("Ack");
            if (err is grpc:Error) {
                log:printError("Error from Connector: " + err.message());
            } else {
                log:print("Server send response : Ack");
            }

        //If the client sends an error to the server, the stream closes and returns the error
        } else if (e is error) {
            log:printError("Error from Connector: " + e.message());
        }
    }
}
