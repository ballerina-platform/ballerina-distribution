import ballerina/io;

type InvalidIntDetail record {|
    int value;
|};

type InvalidI32Detail record {|
    int:Signed32 value;
|};

type InvalidIntError error<InvalidIntDetail>;

type InvalidI32Error error<InvalidI32Detail>;

type DistinctIntError distinct error<InvalidIntDetail>;

type AnotherDistinctIntError distinct error<InvalidIntDetail>;

function createInvalidIntError(int value) returns InvalidIntError {
    return error("Invalid int", value = value);
}

function createDistinctInvalidIntError(int value) returns DistinctIntError {
    return error("Invalid int", value = value);
}

function createInvalidI32Error(int:Signed32 value) returns InvalidI32Error {
    return error("Invalid i32", value = value);
}

public function main() {
    InvalidI32Error e1 = createInvalidI32Error(5);
    // This is true because `InvalidI32Detail` is a subtype of `InvalidIntDetail`.
    io:println(e1 is InvalidIntError);

    InvalidIntError e2 = createInvalidIntError(5);
    // This is false because `e2` don't have the type id corresponding to `DistinctIntError`.
    io:println(e2 is DistinctIntError);

    DistinctIntError e3 = createDistinctInvalidIntError(5);
    // This is true because `InvalidInt` is not a distinct type, thus it ignores the type id of `e3`.
    io:println(e3 is InvalidIntError);

    // This is false because `DistinctIntError` and `AnotherDistinctIntError` have different type ids.
    io:println(e3 is AnotherDistinctIntError);
}
