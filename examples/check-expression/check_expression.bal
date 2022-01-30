import ballerina/io;

// Convert `bytes` to a `string` value and then to an `int` value.
function intFromBytes(byte[] bytes) returns int|error {

    // Use `check` with an expression that may return `error`.
    // If `string:fromBytes(bytes)` returns an `error` value, `check`
    // makes the function return the `error` value here.
    // If not, the returned `string` value is used as the
    // value of the `str` variable.
    string str = check string:fromBytes(bytes);


    return int:fromString(str);
}

public function main() {
    int|error res = intFromBytes([104, 101, 108, 108, 111]);
    io:println(res);
}
