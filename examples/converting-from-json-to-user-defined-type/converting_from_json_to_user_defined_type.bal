import ballerina/io;

type Coord record {
    float x;
    float y;
};

public function main() {
    json j = {x: 1.0, y: 2.0};
    
    
    // With mutable values, it would not be type-safe to allow a cast.
    // Cast to `T` will work on the mutable structure `s` only if the inherent type
    // of `s` is a subtype of `T`.
    // Use `cloneReadOnly()` to create a read-only copy of the mutable value.
    // Then, you can cast the resulting immutable value successfully.
    json k = j.cloneReadOnly();
    Coord c = <Coord> k;

    io:println(c.x);
    io:println(c.y);
}
