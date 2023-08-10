import ballerina/io;

function demo(anydata v) returns float|error {
    // `v` is cast to the `float` type by calling `ensureType()`.
    // `ensureType()` returns an error if the cast is not possible unlike the usual cast operation,
    // which panics.
    return v.ensureType(float);
}

public function main() {
    float|error f1 = demo(12.5d);
    io:println(f1);

    float|error f2 = demo("12.5");
    io:println(f2);
}
