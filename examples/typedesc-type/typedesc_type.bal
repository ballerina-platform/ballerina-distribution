import ballerina/io;

type R record {
    int x;
    int y;
};

// `t` is a `typedesc` representing a record type and type `R`, which is a record, is
// assigned to it.
typedesc<record {}> t = R;

public function main() {
    R r = {x: 1, y: 2};
    any v = r;

    // `typeof` operator gets the dynamic type of a value and dynamic types for mutable
    // structures are inherent types.
    // It is retrieving the `typedesc` value of `v` and `t` which is then compared.
    io:println(typeof v === t);
}
