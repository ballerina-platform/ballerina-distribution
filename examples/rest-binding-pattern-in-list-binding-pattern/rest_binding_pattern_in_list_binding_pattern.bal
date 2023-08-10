import ballerina/io;

public function main() {

    float[4] [first, second, ...others] = getScores();

    // The first two values returned by `getScores()` will be bound to the 
    // variables `first` and `second` which will be of `float` type.
    io:println(first);
    io:println(second);

    // The rest of the values will be bound to `others`, which will be of `float[]` type.
    io:println(others);
}

function getScores() returns float[4] {
    return [1.2, 2.3, 3.4, 4.5];
}
