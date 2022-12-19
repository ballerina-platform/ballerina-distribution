import ballerina/io;
 
type Coord record {
    float x;
    float y;
};
 
public function main() {
    json j = {x: 1.0, y: 2.0};
    
    // Here the inherent type of `j` is not a subtype of `Coord`. 
    // Therefore `j` cannot be directly converted to `Coord`.
    // Use `cloneReadOnly()` to create a read-only copy of the mutable value `j`.
    // Then, the resulting immutable value can be casted successfully.
    json k = j.cloneReadOnly();
    Coord c = <Coord> k;
    
    io:println(c.x);
    io:println(c.y);
}
