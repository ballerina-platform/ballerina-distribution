import ballerina/io;

public function main() {
    // 1 belongs to `int`.
    io:println(1 is int);
    // [10, 20, 30] belongs to `int[]`.
    io:println([10, 20, 30] is int[]);
}
