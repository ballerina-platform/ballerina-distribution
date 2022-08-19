import ballerina/io;

type Id [int, string...];

function process(Id id) {
    // `id` is destructured with a binding pattern such that path contains all the rest values
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
