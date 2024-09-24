import ballerina/io;

public function main() {
    int a = 10;
    int b = 20;

    // Adds two integers.
    io:println(a + b);
    // Subtracts two integers.
    io:println(a - b);
    // Multiplies two integers.
    io:println(a * b);
    // Divides two integers.
    io:println(b / a);
    // Computes the modulus of two integers.
    io:println(b % a);
    // Compares two integers.
    io:println(a < b);
    io:println(a >= b);

    float e = 10.5;
    float f = 20.5;

    // Adds two floating-point numbers.
    io:println(e + f);
    // Subtracts two floating-point numbers.
    io:println(e - f);
    // Multiplies two floating-point numbers.
    io:println(e * f);
    // Divides two floating-point numbers.
    io:println(e / f);
    // Compares two floating-point numbers.
    io:println(e <= f);
    io:println(e > f);

    boolean c = true;
    boolean d = false;

    // Performs logical AND between two boolean values.
    io:println(c && d);
    // Performs logical OR between two boolean values.
    io:println(c || d);

    int g = 10;
    int h = 20;

    // Performs bitwise AND between two integers.
    io:println(g & h);
    // Performs bitwise OR between two integers.
    io:println(g | h);
    // Performs bitwise XOR between two integers.
    io:println(g ^ h);
    // Left shifts an integer by 2 bits.
    io:println(g << 2);
    // Right shifts an integer by 2 bits (signed).
    io:println(g >> 2);
    // Right shifts an integer by 2 bits (unsigned).
    io:println(g >>> 2);

    string i = "Hello";
    string j = "Ballerina";

    // Concatenates two strings.
    io:println(i + " " + j);
}
