import ballerina/io;

type Pair record {
    int x;
    int y;
};

function matchFn(Pair pair) {
    match pair {
        // The binding pattern below also has a rest binding pattern to capture the additional fields
        // that may be defined in `pair` since it is an open record.
        // Type of rest can be considered a map of `anydata`. However, it cannot contain the 
        // `x` or `y` keys. This can be represented using the `never` type as explained in the example for
        // the `never` type.
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
