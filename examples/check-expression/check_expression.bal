import ballerina/io;

// Convert `bytes` to a `string` value and then to an `int` value.
function intFromBytes(byte[] bytes) returns int|error {
    string|error res = string:fromBytes(bytes);
    // Explicitly check if the result is an error and 
    // immediately return if so.
    if res is error {
        return res;
    }
    return int:fromString(res);
}

// Same as `intFromBytes` but with `check` instead of explicitly checking for error and returning.
function intFromBytesWithCheck(byte[] bytes) returns int|error {
    string str = check string:fromBytes(bytes);
    return int:fromString(str);
}

public function main() {
    int|error res1 = intFromBytesWithCheck([104, 101, 108, 108, 111]);
    io:println(res1);
    int|error res2 = intFromBytes([104, 101, 108, 108, 111]);
    io:println(res2);
}
