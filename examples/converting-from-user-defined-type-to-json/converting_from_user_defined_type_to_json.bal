import ballerina/io;

// Closed type.
type ClosedCoord record {|
    float x;
    float y;
|};

// Open type, can have additional `anydata` fields.
type OpenCoord record {
    float x;
    float y;
};

public function main() {
    ClosedCoord a = {x: 1.0, y: 2.0};
    // Nothing to do.
    json j = a;

    io:println(j);

    OpenCoord b = {x: 1.0, y: 2.0, "z": "city"};
    // Use `toJson()` to convert `anydata` to `json`.
    // Usually happens automatically.
    json k = b.toJson();

    io:println(k);
}
