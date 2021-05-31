import ballerina/io;

// Defines a type named `MapArray`.
type MapArray map<string>[];

public function main() {
    // Creates a `MapArray` value.
    // `arr` has elements which are of `map<string>` type.
    MapArray arr = [
        {"x": "foo"},
        {"y": "bar"}
    ];

    io:println(arr[0]);
}
