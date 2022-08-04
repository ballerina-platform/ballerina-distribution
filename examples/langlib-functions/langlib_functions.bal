import ballerina/io;

public function main() {
    // You can call langlib functions using the method-call syntax.
    string s = "abc".substring(1, 2);

    io:println(s);

    // `n` will be 1.
    int n = s.length();
    io:println(n);

    // `s.length()` is same as `string:length(s)`.
    int m = string:length(s);
    io:println(m);

}
