import ballerina/io;

type Pair record {
    int x;
    int y;
};

function matchFn(Pair pair) {
    match pair {
        // Below binding pattern also has a rest binding pattern to capture the additional fields
        // that may be defined in `pair`, since it is an open record.
        // Type of rest can be considered a map of anydata, however it cannot contain the keys
        // x or y. This is achieved using never type;
        var {x, y, ...rest} => {
            io:println(x, ", ", y);
            io:println(rest);
        }
    }
}

public function main() {
    Pair pair = {x : 1, y : 2, "u" : 3 , "v" : 4};
    matchFn(pair);
}
