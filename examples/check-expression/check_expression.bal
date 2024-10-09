import ballerina/io;

// Same as `intFromBytesWithCheck` but with explicit error handling.
function intFromBytes(byte[] bytes) returns int|error {
    string|error res = string:fromBytes(bytes);
    // Handling the error explicitly.
    if res is error {
        return res;
    }
    return int:fromString(res);
}

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
