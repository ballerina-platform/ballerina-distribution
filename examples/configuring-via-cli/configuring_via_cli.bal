 import ballerina/io;

enum HttpVersion {
   HTTP_1_0 = "1.0",
   HTTP_1_1 = "1.1",
   HTTP_2_0 = "2.0"
}

// The configurable variables of `float`, `union`, and `enum` types are initialized.
configurable float maxPayload = 1.0;
configurable string|int localId = ?;
configurable HttpVersion httpVersion = HTTP_1_0;

public function main() {
   io:println("maximum payload (in MB): ", maxPayload);
   io:println("local ID: ", localId);
   io:println("HTTP version: ", httpVersion);
}
