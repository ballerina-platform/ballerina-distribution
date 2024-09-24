import ballerina/io;

public function main() {
    int a = 10;

    // Negate the value of `a`.
    io:println(-a);
    // Perform bitwise NOT on `a`.
    io:println(~a);

    float b = -10.5;

    // Negate the value of `b`.
    io:println(-b);

    boolean c = true;

    // Perform logical NOT on `c`.
    io:println(!c);
}
