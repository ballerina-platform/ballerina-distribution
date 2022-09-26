import ballerina/io;

type Pair record {
    int x;
    int y;
};

type Rec record {
    Pair p;
};

function matchFn1(Pair pair) {
    match pair {
        // The binding pattern below matches mappings that contain at least the fields `x` and `y`.
        // The values of these fields can be accessed via the variables `x` and `y` within this block.
        var {x, y} => {
            io:println(x, ", ", y);
        }
    }
}

function matchFn2(Pair pair) {
    match pair {
        // The binding pattern below also has a rest binding pattern to capture the additional fields
        // that may be defined in `pair` since it is an open record.
        // Type of rest can be considered a map of `anydata`. However, it cannot contain the
        // `x` or `y` keys. This can be represented using the `never` type as explained in the example for
        // the `never` type.
        var {x, y, ...rest} => {
            io:println(x, ", ", y, ", ", rest);
        }
    }
}

function matchFn3(Rec r) {
    match r {
        // Below pattern matches a mappings that have a field `p` where its value is another mapping
        // that contains at least the fields `x` and `y`.
        var {p: {x, y}} => {
            io:println(x, ", ", y);
        }
    }
}

public function main() {
    Pair pair = {x: 1, y: 2, "u": 3 , "v": 4};
    matchFn1(pair);
    matchFn2(pair);
    Rec r = {p: pair};
    matchFn3(r);
}
