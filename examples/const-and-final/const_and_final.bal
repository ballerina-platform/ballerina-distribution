import ballerina/io;

const int MAX_VALUE = 1000;

// Constants can be defined without the type. Then, the type is inferred from the right-hand side.
const URL = "https://ballerina.io";

// Mapping and list constants can also be defined.
const HTTP_OK = {httpCode: 200, message: "OK"};
const ERROR_CODES = [200, 202, 400];

// The value for variable `msg` can only be assigned once.
final string msg = loadMessage();

public function main() {
    io:println(MAX_VALUE);
    io:println(URL);
    io:println(HTTP_OK);
    io:println(ERROR_CODES);
    io:println(msg);
}

function loadMessage() returns string {
    return "Hello World";
}
