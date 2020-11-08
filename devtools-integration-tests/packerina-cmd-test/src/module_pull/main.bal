import ballerina/io;
import suganya/calc;

# Prints `Hello World`.

public function main() {
    io:println(calc:add(5, 4));
    io:println(calc:substract(10, 5));
    io:println(calc:multiply(15, 4));
    io:println(calc:divide(15, 5));
}
