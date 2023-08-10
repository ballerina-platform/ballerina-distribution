import ballerina/grpc;
import ballerina/io;
import ballerina/protobuf.types.wrappers;
import ballerina/time;

public function main() returns error? {
    HelloWorldClient ep = check new ("http://localhost:9090");
    // Get a deadline time by adding 5 seconds to the current time.
    time:Utc current = time:utcNow();
    time:Utc deadline = time:utcAddSeconds(current, 5);
    // Set the deadline time as a header.
    map<string|string[]> headers = grpc:setDeadline(deadline);
    wrappers:ContextString|grpc:Error response = ep->helloContext({content: "WSO2", headers: headers});
    if response is grpc:Error {
        io:println("An error has occured : " + response.message());
    } else {
        io:println(response.content);
    }
}
