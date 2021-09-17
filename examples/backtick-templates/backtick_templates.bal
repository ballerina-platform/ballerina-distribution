import ballerina/io;

public function main() {
    string name = "James";

    // Concatenates `Hello, ` strings with the `name` value.
    string s1 = string`Hello, ${name}`;
    io:println(s1);

    // Concatenates `Backtick:` strings with `.
    string s2 = string`Backtick:${"`"}`;
    io:println(s2);
}
