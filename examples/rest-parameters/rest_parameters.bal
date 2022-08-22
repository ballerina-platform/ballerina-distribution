import ballerina/io;

function foo(int n, string... s) {
    io:println(n);
    io:println(s[0]);
    io:println(s[1]);
    io:println(s[2]);
    io:println(s);
}

public function main() {
    // Param `s` will be ["x", "y", "z"].
    foo(1, "x", "y", "z");
}
