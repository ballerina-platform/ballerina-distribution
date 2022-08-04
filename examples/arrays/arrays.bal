import ballerina/io;

public function main() {
    int[] v = [1, 2, 3];

    // `v[i]` does indexed access.
    int n = v[0];

    io:println(n);

    // `v[i]` is an `lvalue`.
    v[3] = 4;

    // `len` will be 3.
    int len = v.length();
    io:println(len);
}
