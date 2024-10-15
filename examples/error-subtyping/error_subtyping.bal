import ballerina/io;

type InvalidIntDetail record {|
    int value;
|};

// Subtype of `InvalidIntDetail`.
type InvalidI32Detail record {|
    int:Signed32 value;
|};

// Error with the `InvalidIntDetail` type as the detail type.
type InvalidIntError error<InvalidIntDetail>;

// Error with `InvalidI32Detail` as the detail type. Thus it is a subtype of `InvalidIntError`.
type InvalidI32Error error<InvalidI32Detail>;

// Distinct error with the `InvalidIntDetail` type as the detail type and a unique type ID.
// Therefore, this is a proper subtype of `InvalidIntError`, but doesn't have a subtype relationship 
// with `AnotherDistinctIntError` because they have different type IDs.
type DistinctIntError distinct error<InvalidIntDetail>;

// Another distinct error with `InvalidIntDetail` as the detail type, but a different type ID to `DistinctIntError`
// This is also a proper subtype of `InvalidIntError`, but doesn't have a subtype relationship with `DistinctIntError`
type AnotherDistinctIntError distinct error<InvalidIntDetail>;

public function main() {
    InvalidI32Error e1 = createInvalidI32Error(5);
    io:println(e1 is InvalidIntError);

    InvalidIntError e2 = createInvalidIntError(5);
    io:println(e2 is DistinctIntError);

    DistinctIntError e3 = createDistinctInvalidIntError(5);
    // This is true because `InvalidInt` is not a distinct type, thus it ignores the type id of `e3`.
    io:println(e3 is InvalidIntError);

    // This is false because `DistinctIntError` and `AnotherDistinctIntError` have different type ids.
    io:println(e3 is AnotherDistinctIntError);
}

// Helper functions to create errors.
function createInvalidIntError(int value) returns InvalidIntError {
    return error("Invalid int", value = value);
}

function createDistinctInvalidIntError(int value) returns DistinctIntError {
    return error("Invalid int", value = value);
}

function createInvalidI32Error(int:Signed32 value) returns InvalidI32Error {
    return error("Invalid i32", value = value);
}
