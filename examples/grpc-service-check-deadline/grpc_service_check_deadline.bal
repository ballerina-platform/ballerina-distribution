import ballerina/grpc;
import ballerina/protobuf.types.wrappers;

@grpc:Descriptor {
    value: GRPC_SIMPLE_DESC
}
service "HelloWorld" on new grpc:Listener(9090) {
    remote function hello(wrappers:ContextString request) returns string|error {
        // Check if the deadline has been exceeded and response accordingly.
        boolean isCancelled = check grpc:isCancelled(request.headers);
        if isCancelled {
            return error grpc:DeadlineExceededError("Exceeded the configured deadline");
        }
        return "Hello";
    }
}
