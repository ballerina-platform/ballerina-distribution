import ballerina/io;

boolean flag = true;

// Here's a conditional expression. Uses C syntax.
int n = flag ? 1 : 2;

public function main() {
    // Parentheses are optional in conditions, but curly braces are required in `if/else` and other compound statements.
    if flag {
        io:println(1);
    } else {
        io:println(2);
    }

}
