import ballerina/io;

function intFromBytesWithCheck(byte[] bytes) returns int|error {
    string str = check string:fromBytes(bytes);
    return int:fromString(str);
}

// Same as `intFromBytesWithCheck` but with explicit error handling.
function intFromBytesExplicit(byte[] bytes) returns int|error {
    string|error res = string:fromBytes(bytes);
    // Handling the error explicitly.
    if res is error {
        return res;
    }
    return int:fromString(res);
}

public function main() {
    int|error res1 = intFromBytesWithCheck([104, 101, 108, 108, 111]);
    io:println(res1);
    int|error res2 = intFromBytesExplicit([104, 101, 108, 108, 111]);
    io:println(res2);
}
