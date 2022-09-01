import ballerina/io;

type Pair record {
    int x;
    int y;
};

Pair p = {
    x: 1,
    y: 2,
    "color": "blue"
};

// This is a record with two `x` and `y` optional fields of the `never` type.
// However, as you cannot have values of the `never` type,
// the net result is that you cannot have the `x` and `y`fields in the record.
type PairRest record { 
    never x?; 
    never y?; 
};

// The function always panics. It never returns normally.
// Therefore, the return type can be defined as `never`.
function whoops() returns never {
    panic error("whoops");
}

public function main() {
    // `xml<never>` describes the XML type that has no constituents.
    // Therefore `x` is an empty XML sequence.
    xml<never> x = xml ``;
    io:println(x);

    // The `rest` variable contains the fields in `p` other than `x` and `y`.
    var {x: _, y: _, ...rest} = p;
    // Type of `rest` is a subtype of `PairRest`.
    PairRest pairRest = rest;
    io:println(pairRest);
    // Call the function that always panics.
    whoops();
}
