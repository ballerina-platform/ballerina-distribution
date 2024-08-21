import ballerina/http;
import ballerina/io;

public function main() returns error? {
    http:Client clientEp = check new ("localhost:9090");
    // Make a GET request to the "/stocks" endpoint and receive a stream of `http:SseEvent`.
    stream<http:SseEvent, error?> eventStream = check clientEp->/stocks;
    // Iterate over the stream and handle each event.
    check from http:SseEvent event in eventStream
        do {
            io:println("Stock price: ", event.data);
        };
}
