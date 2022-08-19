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

// This is a record with two optional fields `x` and `y`, of the `never` type.
// But since you cannot have variables with never type,
// the net result is that you cannot have fields `x` and `y` in the record.
type PairRest record { never x?; never y?; };

// The function always panics. It never returns normally.
// Therefore, it is perfectly fine to describe the return type as `never`.
function whoops() returns never {
    panic error("whoops");
}

public function main() {
    // The variable `rest` contains fields other than `x` and `y`.
    var {x: _, y: _, ...rest} = p;
    // Type of `rest` is a subtype of `PairRest`
    PairRest pairRest = rest;
    io:println(pairRest);
    whoops();
}
