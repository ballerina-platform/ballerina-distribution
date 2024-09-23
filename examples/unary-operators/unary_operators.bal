import ballerina/io;

public function main() {
    int a = 10;

    // Negates the value
    io:println(-a);
    // Bitwise NOT
    io:println(~a);

    float b = 10.5;

    // Negates the value
    io:println(-b);

    boolean c = true;

    // Logical NOT
    io:println(!c);
}
