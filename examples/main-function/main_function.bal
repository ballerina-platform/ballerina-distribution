import ballerina/io;

// The `main` function can accept command-line arguments and return `error` or `nil`.
public function main(int value) returns error? {
    io:println(value);

    if value >= 3 {
        return error("Input should less than 3");
    }
}
