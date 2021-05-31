import ballerina/io;

type Coord record {
    float x;
    float y;
};

public function main() returns error? {
    json j = {x: 1.0, y: 2.0};

    // Argument is a typedesc value.
    // Static return type depends on argument.
    Coord c = check j.cloneWithType(Coord);
    io:println(c.x);

    // Argument defaulted from context.
    Coord d = check j.cloneWithType();
    io:println(d.x);
}
