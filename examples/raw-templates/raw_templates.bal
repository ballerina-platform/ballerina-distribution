import ballerina/io;

function foo() returns boolean {
    return false;
}

public function main() {
    int x = 5;
    error y = error("foo");
    object:RawTemplate rawTemplate = `x is ${x}. y is ${y}. The result of calling foo is ${foo()}`;
    io:println(rawTemplate.strings);
    io:println(rawTemplate.insertions);
}
