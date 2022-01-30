import ballerina/io;

// Defines a `record` type named `Coord`.
type Coord record {
    int x;
    int y;
};

public function main() {
    // Creates a `record`, specifying values for its fields.
    record { int x; int y; } r = {
        x: 1,
        y: 2
    };

    // Creates a `Coord` record.
    Coord c = {
        x: 1,
        y: 2
    };

    int a = r.y;
    io:println(a);

    int b = c.x;
    io:println(b);
}
