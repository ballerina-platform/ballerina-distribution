import ballerina/io;

public function main() {
    int a = 10;

    // Negate the value of `a`.
    io:println(-a);
    
    // Invert the bits of `a`.
    io:println(~a);

    float b = -10.5;

    // Negate the value of `b`.
    io:println(-b);
    
    // Return the value of `b`.
    io:println(+b);

    boolean c = true;

    // Invert the boolean value of `c`.
    io:println(!c);
}
