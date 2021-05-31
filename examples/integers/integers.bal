import ballerina/io;

public function main() {
    int m = 1;

    // Integer literals can be hexadecimal (but not octal).
    int n = 0xFFFF;

    // You can use compound assignment operations such as `+=` and `-=`. 
    n += m;

    io:println(n);
}
