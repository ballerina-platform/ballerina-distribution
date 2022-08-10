import ballerina/io;

// The `decimal` type represents the set of 128-bits IEEE 754R decimal floating point numbers.
decimal nanos = 1d/1000000000d;

function floatSurprise() {
    float f = 100.10 - 0.01;
    io:println(f);
}

public function main() {
    floatSurprise();
    io:println(nanos);

    // Numeric literals can use the `d` suffix for them to be interpreted as `decimal` values
    // (similarly, the `f` suffix can be used for `float`).
    var d = 12345d;
    io:println(d is decimal);
}
