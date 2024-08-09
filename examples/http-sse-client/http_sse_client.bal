import ballerina/http;
import ballerina/io;

public function main() returns error? {
    http:Client clientEp = check new ("localhost:9090");
    stream<http:SseEvent, error?> eventStream = check clientEp->/stocks;
    check from http:SseEvent event in eventStream
        do {
            io:println("Stock price: ", event.data);
        };
}
