import ballerina/io;

function subString(string str, int 'start = 0, int end = str.length()) returns string {
    return str.substring('start, end);

}

public function main() {
    // Call the `subString` function with using defaults values of parameters with names `start` and `end`.
    io:println(subString("Ballerina Language"));

    // Call the `subString` function by passing value for default parameter with name `start`.
    io:println(subString("Ballerina Language", 10));

    // Call the `subString` function by passing values for parameters with name `start` and `end`.
    io:println(subString("Ballerina Language", 10, 14));
}
