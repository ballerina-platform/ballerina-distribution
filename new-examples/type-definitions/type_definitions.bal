import ballerina/io;

type MapArray map<string>[];

public function main() {
    MapArray arr = [
        {"x": "foo"},
        {"y": "bar"}
    ];
    io:println(arr[0]);
}
