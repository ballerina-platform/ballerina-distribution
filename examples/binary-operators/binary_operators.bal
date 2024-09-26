import ballerina/io;

public function main() {
    int a = 10;
    int b = 20;

    // Add two integers.
    int sum = a + b;
    io:println(sum);

    // Subtract two integers.
    int difference = a - b;
    io:println(difference);

    // Multiply two integers.
    int product = a * b;
    io:println(product);

    // Divide two integers.
    int quotient = b / a;
    io:println(quotient);

    // Compute the integer remainder.
    int remainder = b % a;
    io:println(remainder);

    // Check if `a` is less than `b`.
    boolean isLessThan = a < b;
    io:println(isLessThan);

    // Check if `a` is greater than or equal to `b`.
    boolean isGreaterOrEqual = a >= b;
    io:println(isGreaterOrEqual);

    float e = 10.5;
    float f = 20.5;

    // Add two floating-point numbers.
    float floatSum = e + f;
    io:println(floatSum);

    // Subtract two floating-point numbers.
    float floatDifference = e - f;
    io:println(floatDifference);

    // Multiply two floating-point numbers.
    float floatProduct = e * f;
    io:println(floatProduct);

    // Divide two floating-point numbers.
    float floatQuotient = e / f;
    io:println(floatQuotient);

    // Check if `e` is less than or equal to `f`.
    boolean isLessOrEqual = e <= f;
    io:println(isLessOrEqual);

    // Check if `e` is greater than `f`.
    boolean isGreaterThan = e > f;
    io:println(isGreaterThan);

    boolean c = true;
    boolean d = false;

    // Perform logical AND between two boolean values.
    boolean logicalAnd = c && d;
    io:println(logicalAnd);

    // Perform logical OR between two boolean values.
    boolean logicalOr = c || d;
    io:println(logicalOr);

    int g = 10;
    int h = 20;

    // Perform bitwise AND between two integers.
    int bitwiseAnd = g & h;
    io:println(bitwiseAnd);

    // Perform bitwise OR between two integers.
    int bitwiseOr = g | h;
    io:println(bitwiseOr);

    // Perform bitwise XOR between two integers.
    int bitwiseXor = g ^ h;
    io:println(bitwiseXor);

    // Left shift an integer by 2 bits.
    int leftShift = g << 2;
    io:println(leftShift);

    // Right shift an integer by 2 bits (signed).
    int signedRightShift = g >> 2;
    io:println(signedRightShift);

    // Right shift an integer by 2 bits (unsigned).
    int unsignedRightShift = g >>> 2;
    io:println(unsignedRightShift);

    string i = "Hello";
    string j = "Ballerina";

    // Concatenate two strings.
    string concatenatedString = i + " " + j;
    io:println(concatenatedString);
}
