import ballerina/io;

public function main() {
    io:println(1 is int);
    io:println([10, 20, 30] is int[]);
}
