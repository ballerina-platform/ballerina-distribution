import ballerina/io;

public function main() {
    boolean flag = true;
    io:println(flag);

    // following example will output `false`
    io:println(3 < 2);
}