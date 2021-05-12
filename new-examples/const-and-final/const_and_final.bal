import ballerina/io;

const MAX_VALUE = 1000;
const URL = "https://ballerina.io";

final string msg = loadMessage();

public function main() {
    io:println(MAX_VALUE);
    io:println(URL);
    io:println(msg);
}

function loadMessage() returns string {
    return "Hello World";
}
