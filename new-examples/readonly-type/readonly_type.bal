import ballerina/io;

// Value of `s` is an immutable array.
readonly & string s = "foo";

type Row record {
    // Both field and its value are immutable.
    readonly string k;
    int value;
};

table<Row> key(k) t = table [
    // Can safely use `s` as a key.
    { k: s, value: 17 }
];

public function main() {
    io:println(t);
}
