import ballerina/io;

public function main() {
    // Note how the first `\n` is treated as is.
    string s1 = string `line one \n rest of line 1 ${"\n"} second line`;
    io:println(s1);

    // Use interpolations to add ` and  $ characters.
    string s2 = string `Backtick: ${"`"} Dollar: ${"$"}`;
    io:println(s2);

    // Template expressions can be nested.
    string s3 = string `outer ${string `inner ${5} inner rest`} rest`;
    io:println(s3);

    // You can use an empty string interpolation to break a template expression
    // across multiple lines.
    string s4 = string `prefix ${
                ""}middle ${""
                }suffix`;
    io:println(s4);
}
