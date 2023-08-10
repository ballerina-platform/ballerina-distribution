import ballerina/io;

type Position record {
    int x;
    int y;
};

type PositionRecord record {
    Position p;
};

function matchFn1(Position position) {
    match position {
        // The binding pattern below matches mappings that contain at least the fields with the `x` and `y` keys.
        // The values of these fields can be accessed via the `x` and `y` variables within this block.
        var {x, y} => {
            io:println(x, ", ", y);
        }
    }
}

function matchFn2(Position position) {
    match position {
        // The binding pattern below also has a rest binding pattern to capture the additional fields
        // that may be specified in the open record value assigned to the `position` variable.
        // Type of the `rest` variable can be considered a map of `anydata`. However, it cannot contain the
        // `x` or `y` keys. This can be represented using the `never` type as explained in the example for
        // the `never` type.
        var {x, y, ...rest} => {
            io:println(x, ", ", y, ", ", rest);
        }
    }
}

function matchFn3(PositionRecord r) {
    match r {
        // The pattern below matches a mapping that has a field with the `p` key and a value that is another
        // mapping that contains at least the fields with `x` and `y` keys.
        var {p: {x, y}} => {
            io:println(x, ", ", y);
        }
    }
}

public function main() {
    Position position = {x: 1, y: 2, "u": 3 , "v": 4};
    matchFn1(position);
    matchFn2(position);

    PositionRecord r = {p: position};
    matchFn3(r);

}
