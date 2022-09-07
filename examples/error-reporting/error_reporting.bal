import ballerina/io;

// Parses a `string` value to convert to an `int` value. This function may return error values.
// The return type is a union with `error`.
function parse(string s) returns int|error {

    int n = 0;
    int[] cps = s.toCodePointInts();
    foreach int cp in cps {
        int p = cp - 0x30;
        if p < 0 || p > 9 {
            // If `p` is not a digit construct, it returns an `error` value with `not a digit` as the error message.
            return error("not a digit");

        }
        n = n * 10 + p;
    }
    return n;
}

public function main() {
    // An `int` value is returned when the argument is a `string` value, which can be parsed as an integer.
    int|error x = parse("123");

    io:println(x);

    // An `error` value is returned when the argument is a `string` value, which has a character that is not a digit.
    int|error y = parse("1h");

    io:println(y);
}
