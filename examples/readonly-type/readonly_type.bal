import ballerina/io;

// A `const` is immutable.
const s = "Anne";

type Row record {
    // Both the field and its value are immutable.
    readonly string k;
    int value;

};

table<Row> key(k) t = table [
    {k: "John", value: 17}
];

public function main() {
    // Can safely use `s` as a key.
    t.add({k: s, value: 18});

    io:println(t);
}
