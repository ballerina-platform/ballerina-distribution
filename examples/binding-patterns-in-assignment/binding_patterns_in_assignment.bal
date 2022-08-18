import ballerina/io;

int x = 0;
int y = 1;

type IntPair [int, int];

function assign(IntPair ip) {
    // The variable `ip` of type `IntPair` is destructured and
    // assigned to the two module-level variables `x` and `y`.
    [x, y] = ip;

    io:println(x);
    io:println(y);

    swap();

    io:println(x);
    io:println(y);
}

function swap() {
    // The swapping is done between `x` and `y` just by doing
    // tuple destructuring without using a temporary variable
    [x, y] = [y, x];
}

public function main() {
    assign([x, y]);
}
