import ballerina/io;

public function main() {
    // Byte values ranging from 0 to 255
    byte b = 255;
    io:println(b);

    // Byte values can be assigned to int
    int i = b;
    io:println(i);
}
