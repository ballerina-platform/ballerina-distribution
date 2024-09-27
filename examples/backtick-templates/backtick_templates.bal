import ballerina/io;

public function main() {
    string name = "James";

    // Concatenates `Hello, ` strings with the `name` value.
    string s1 = string `Hello, ${name}`;
    io:println(s1);

    // Concatenates `Backtick:` strings with `.
    string s2 = string `Backtick:${"`"}`;
    io:println(s2);

    // If required, a single-line string can be split into a multiline string template by breaking
    // at an interpolation point or using string concatenation.
    string s3 = string `A string-template-expr is evaluated by evaluating the expression in each interpolation in ${
        ""}the order in which they occur.`;
    io:println(s3);
}
