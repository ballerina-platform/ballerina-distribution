import ballerina/io;

function subString(string str, int 'start = 0, int end = str.length())
                                returns string {
    return str.substring('start, end);
}

public function main() {
    // Call the `subString` function using default values of `start` and `end` parameters.
    io:println(subString("Ballerina Language"));

    // Call the `subString` function by passing a value for the default parameter `start`.
    io:println(subString("Ballerina Language", 10));

    // Call the `subString` function by passing values for `start` and `end` default parameters.
    io:println(subString("Ballerina Language", 10, 14));
}
