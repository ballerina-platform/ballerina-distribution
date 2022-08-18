import ballerina/io;

function demo(json j) returns error? {
    // `ensureType()` function is called on `j`, and it returns a `float` value which is
    // assigned to `f`, which is of the `float` type.  This happens because the function parameter
    // `t` of `ensureType()` has a default value of `<>` which causes the compiler to infer the
    // argument for `t` from the function call context.
    float f = check j.ensureType();
    io:println(f);
}

public function main() returns error? {
    check demo(12.5d);
}
