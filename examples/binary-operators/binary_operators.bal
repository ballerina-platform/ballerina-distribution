import ballerina/io;

public function main() {
    int a = 10;
    int b = 20;

    // Addition
    io:println(a + b);
    // Subtraction
    io:println(a - b);
    // Multiplication
    io:println(a * b);
    // Division between two integers
    io:println(b / a);
    // Modulus
    io:println(b % a);
    // Less than
    io:println(a < b);
    // Greater than or equal
    io:println(a >= b);

    float e = 10.5;
    float f = 20.5;

    // Addition
    io:println(e + f);
    // Subtraction
    io:println(e - f);
    // Multiplication
    io:println(e * f);
    // Division
    io:println(e / f);
    // Less than or equal
    io:println(e <= f);
    // Greater than
    io:println(e > f);

    boolean c = true;
    boolean d = false;

    // Logical AND
    io:println(c && d);
    // Logical OR
    io:println(c || d);

    int g = 10;
    int h = 20;

    // Bitwise AND
    io:println(g & h);
    // Bitwise OR
    io:println(g | h);
    // Bitwise XOR
    io:println(g ^ h);
    // Left shift: shifts bits of g to the left by 2, filling right with zeros
    io:println(g << 2);
    // Signed right shift: shifts bits of g to the right by 2, filling left with the sign bit
    io:println(g >> 2);
    // Unsigned right shift: shifts bits of g to the right by 2, filling left with zeros
    io:println(g >>> 2);

    string i = "Hello";
    string j = "Ballerina";

    // String concatenation
    io:println(i + " " + j);
}
