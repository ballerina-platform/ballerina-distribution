import ballerina/io;

// Parses a string to convert to an integer value.
// This function may return error values.
// The return type is a union with error.
function parse(string s) returns int|error {
    int n = 0;
    int[] cps = s.toCodePointInts();
    foreach int cp in cps {
        cp -= 0x30;
        if cp < 0 || cp > 9 {
            // If `cp` is not a digit construct and return 
            // an error value with "not a digit" as the error message.
            return error("not a digit");
        }
        n = n * 10 + cp;
    }
    return n;
}

public function main() {
    // An `int` value is returned when the argument is a string
    // that can be successfully parsed as an integer.
    int|error x = parse("123");
    io:println(x);

    // An `error` value is returned when the argument is a string
    // that has a character that is not a digit.
    int|error y = parse("1h");
    io:println(y);
}
