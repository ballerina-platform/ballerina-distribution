import ballerina/io;

function hello() returns string => "hello";

public function main() {
    // `hello` is inferred to be an `isolated` function.
    boolean x = <any> hello is isolated function;
    io:println(x);
}
