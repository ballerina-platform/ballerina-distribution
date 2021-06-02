import ballerina/io;

public function main() {
    // String literals use double quotes. You can use usual C escapes such as `\t \n`.
    // Numeric escapes specify Unicode code point using one or more hex digits `\u{H}`.
    string grin = "\u{1F600}";

    // String concatenation uses `+` operator.
    string greeting = "Hello" + grin;

    io:println(greeting);

    // `greeting[1]` accesses character at index 1 (zero-based).
    io:println(greeting[1]);

}
