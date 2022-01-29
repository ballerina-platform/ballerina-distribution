import ballerina/io;

// The `decimal` type represents the set of 128-bits IEEE 754R decimal floating point numbers.
decimal nanos = 1d/1000000000d;

// Avoids surprises, which you get with `float` type.
function floatSurprise() {
    float f = 100.10 - 0.01;
    io:println(f);
}

public function main() {
    floatSurprise();
    io:println(nanos);

    // Literals, which belong to type `decimal` use the suffix `d`(`f` suffix is for `float`)
    var d = 12345d;
    io:println(d is decimal);
}
