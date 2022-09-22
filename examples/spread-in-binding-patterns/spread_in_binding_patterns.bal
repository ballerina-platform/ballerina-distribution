import ballerina/io;

type Id [int, string...];

function process(Id id) {
    // The `id` value is destructured with a binding pattern such that the `path` contains all the rest members
    // of the `id` tuple.
    var [n, ...names] = id;
    io:println(n);
    io:println(names.length());
    foreach string name in names {
        io:println(name);
    }
}

public function main() {
    Id id = [124, "Peter", "Jackson"];
    process(id);
}
