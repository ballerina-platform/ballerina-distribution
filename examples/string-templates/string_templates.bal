import ballerina/io;

public function main() {
    string word = "world";
    string s0 = string `Hello, ${word}!`;
    io:println(s0);

    // Use interpolations to use escape characters.
    // Note how the first `\n` is treated as is.
    string s1 = string `line one \n rest of line 1 ${"\n"} second line`;
    io:println(s1);

    // Use interpolations to add the ` and  $ characters.
    string s2 = string `Backtick: ${"`"} Dollar: ${"$"}`;
    io:println(s2);

    // A string template expression can be written on multiple lines by breaking at interpolations.
    string s3 = string `T_1 is ${
                1}, T_2 is ${1 +
                2} and T_3 is ${1 + 2 + 3
                }`;
    io:println(s3);

    // If there are no interpolations to break at a required point, you can introduce an interpolation with an empty
    // string.
    string s4 = string `prefix ${
                ""}middle ${""
                }suffix`;
    io:println(s4);
}
