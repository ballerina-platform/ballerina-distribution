import ballerina/io;

function parseInt(string s) returns int|error {
    if s.length() == 0 {
        return error("empty string"); // Create error with only a message.
    }
    int pow = 0;
    int val = 0;
    foreach string:Char char in s {
        int|error digit = parseDigit(char);
        if digit is error {
            // Create a new error value that include the error from parsing as
            // the cause.
            return error("failed to parse digit", digit, stringValue = s);
        }
        val += val * 10 + digit;
        pow += 1;
    }
    return val;
}

function parseDigit(string:Char s) returns int|error {
    match s {
        "1" => {
            return 1;
        }
        "2" => {
            return 2;
        }
        "3" => {
            return 3;
        }
        "4" => {
            return 4;
        }
        "5" => {
            return 5;
        }
        "6" => {
            return 6;
        }
        "7" => {
            return 7;
        }
        "8" => {
            return 8;
        }
        "9" => {
            return 9;
        }
        "0" => {
            return 0;
        }
        _ => {
            // Create an error value with field `charValue` in it's detail.
            return error("unexpected char for digit value", charValue = s);
        }
    }
}

public function main() {
    int|error result = parseInt("1x3");
    if result is error {
        printError(result);
    }
}

// Helper function to print internals of error value.
function printError(error err, int depth = 0) {
    string indent = "".join(...from int _ in 0 ..< depth
        select "    ");
    io:println(indent + "message: ", err.message());
    io:println(indent + "details ", err.detail());
    io:println(indent + "stack trace: ", err.stackTrace());
    error? cause = err.cause();
    if cause != () {
        io:println(indent + "cause: ", cause);
        printError(cause, depth + 1);
    }
}
