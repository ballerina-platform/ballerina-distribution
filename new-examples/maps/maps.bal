import ballerina/io;

public function main() {
    map<int> m = {
        "x": 1,
        "y": 2
    };

    // `m[k]` gets the entry for `k`; `nil` if missing.
    int? v = m["x"];
    io:println(v);

    // `m[k]` is an `lvalue`.
    m["z"] = 5;

    // Using `m["x"]` wouldn't work here because type would be `int?`
    // not `int`.
    m["z"] = m.get("x");
}
