import ballerina/io;

public function main() returns error? {
    int a = 1;
    float b = 2.1;
    decimal c = 3.24;

    // The `json` type allows `int|float|decimal`.
    json[] d = [a, b, c];

    // `toJsonString()` will convert `int|float|decimal` into JSON
    // numeric syntax.
    string e = d.toJsonString();

    io:println(e);

    // `fromJsonString()` converts JSON numeric syntax into `int`,
    // if possible, and otherwise `decimal`.
    json f = check e.fromJsonString();

    io:println(f);

    json[] g = <json[]> f;

    io:println(typeof g[0]);
    io:println(typeof g[1]);
    io:println(typeof g[2]);

    // `cloneWithType()` or `ensureType()` will convert from `int` or `decimal` into the user's
    // chosen numeric type.
    float h = check g[2].ensureType();

    io:println(h);

    // `-0` is an edge case: represented as `float`.
    string i = "-0";

    io:println(typeof check i.fromJsonString());
    return;
}
