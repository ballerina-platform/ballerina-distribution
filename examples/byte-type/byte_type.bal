import ballerina/io;

public function main() {
    // The `byte` type consists of integers ranging from `0` to `255`.
    byte b = 255;
    io:println(b);

    // Since the set of possible `byte` values is a subset of `int` values,
    // the `byte` type is a subtype of the `int` type.
    int i = b;
    io:println(i);
}
