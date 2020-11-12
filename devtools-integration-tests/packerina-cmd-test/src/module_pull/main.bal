import ballerina/io;
import suganya/calculator;

public function main() {
    io:println(calculator:add(5, 4));
    io:println(calculator:substract(10, 5));
    io:println(calculator:multiply(15, 4));
    io:println(calculator:divide(15, 5));
}
