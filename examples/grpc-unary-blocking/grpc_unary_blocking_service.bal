// This is the server implementation for the unary blocking/unblocking scenario.
import ballerina/grpc;
import ballerina/log;

@grpc:ServiceDescriptor {
    descriptor: ROOT_DESCRIPTOR,
    descMap: getDescriptorMap()
}
service /HelloWorld on new grpc:Listener(9090) {

    isolated remote function hello(grpc:Caller caller, string name,
                             grpc:Headers headers) {
        log:print("Server received hello from " + name);
        string message = "Hello " + name;
        // Reads custom headers in request message.
        string reqHeader = headers.get("client_header_key") ?: "none";
        log:print("Server received header value: " + reqHeader);

        // Writes custom headers to response message.
        grpc:Headers resHeader = new;
        resHeader.setEntry("server_header_key", "Response Header value");

        // Sends response message with headers.
        grpc:Error? err = caller->send(message, resHeader);
        if (err is grpc:Error) {
            log:printError("Error from Connector: " + err.message());
        }

        // Sends `completed` notification to caller.
        grpc:Error? result = caller->complete();
        if (result is grpc:Error) {
            log:printError("Error in sending completed notification to caller",
                err = result);
        }
    }
}
