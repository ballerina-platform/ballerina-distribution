import ballerina/io;

// Defines a record type named `Coord`.
type Coord record {
    int x;
    int y;
};

public function main() {
    record { int x; int y; } r = {
        x: 1,
        y: 2
    };
    Coord c = {
        x: 1,
        y: 2
    };

    // a will be 2
    int a = r.y;
    // b will be 1.
    int b = c.x;
}
