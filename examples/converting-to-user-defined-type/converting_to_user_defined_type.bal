import ballerina/io;

type Coord record {
    float x;
    float y;
};

public function main() returns error? {
    json j = {x: 1.0, y: 2.0};

    // Argument is a `typedesc` value.
    // The static return type depends on the argument.
    Coord c = check j.cloneWithType(Coord);

    io:println(c.x);

    // Argument defaulted from the context.
    Coord d = check j.cloneWithType();

    io:println(d.x);
    return;
}
