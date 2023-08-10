import ballerina/io;

function foo(int n, string... s) {
    io:println(n);
    io:println(s[0]);
    io:println(s[1]);
    io:println(s[2]);
    io:println(s);
    io:println(s is string[]);
}

public function main() {
    // The `s` parameter will be `["x", "y", "z"]`.
    foo(1, "x", "y", "z");
}
