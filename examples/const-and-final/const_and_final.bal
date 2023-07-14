import ballerina/io;

// Constants can be defined without the type. Then, the type is inferred from the right-hand side.
const MAX_VALUE = 1000;
const URL = "https://ballerina.io";

// Map and list can be declared as constant.
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
