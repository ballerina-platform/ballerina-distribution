import ballerina/io;

type Id [int, string...];

function process(Id id) {
    // The `id` value is destructured with a binding pattern such that the `path` contains all the rest members
    // of the `id` tuple.
    var [n, ...path] = id;
    io:println(n);
    foreach string s in path {
        io:println(s);
    }
}

public function main() {
    Id id = [1, "hello", "world"];
    process(id);
}
