import ballerina/io;

public function main() {
    // Creates a `map` constrained by the `int` type.
    map<int> m = {
        "x": 1,
        "y": 2
    };

    // Gets the entry for `x`.
    int? v = m["x"];

    io:println(v);

    // Adds a new entry for `z`.
    m["z"] = 5;

    // Using `m["x"]` wouldn't work here because type would be `int?`,
    // not `int`.
    m["z"] = m.get("x");

}
