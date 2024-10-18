
import ballerina/io;
import ballerina/lang.'object as 'object;

function foo() returns boolean {
    return false;
}

public function main() {
    int x = 5;
    error y = error("foo");
    'object:RawTemplate rawTemplate = `x is ${x}. y is ${y}. result of calling foo is ${foo()}`;
    io:println(rawTemplate.strings);
    io:println(rawTemplate.insertions);
}
