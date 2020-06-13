// This is the server implementation for the client streaming scenario.
import ballerina/grpc;
import ballerina/log;

service HelloWorld on new grpc:Listener(9090) {

    resource function lotsOfGreetings(grpc:Caller caller, stream<string,error> clientStream) {
        log:printInfo("Client connected sucessfully.");
        //Read and process each message in the client stream
        error? e = clientStream.forEach(function(string name) {
            log:printInfo("Server received greet: " + name);
        });

        //Once the client sends a notification to indicate the end of the stream, 'grpc:EOS' is returned by the stream
        if (e is grpc:EOS) {
            grpc:Error? err = caller->send("Ack");
            if (err is grpc:Error) {
                log:printError("Error from Connector: " + err.reason() + " - "
                                                + <string>err.detail()["message"]);
            } else {
                log:printInfo("Server send response : Ack");
            }

        //If the client sends an error to the server, the stream closes and returns the error
        } else if (e is error) {
            log:printError("Error from Connector: " + e.reason() + " - "
                                                       + <string>e.detail()["message"]);
        }
    }
}
