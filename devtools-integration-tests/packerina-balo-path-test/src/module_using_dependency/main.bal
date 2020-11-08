import ballerina/io;
import test/foo;

# Prints `Hello World`.

public function main() {
    io:println(foo:say());
}
