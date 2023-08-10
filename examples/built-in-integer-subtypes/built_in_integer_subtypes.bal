import ballerina/io;

// The `fn` function accepts an argument that belongs to `int:Unsigned32`
// and prints the result of performing the bitwise `&` operation with 
// the `int:Unsigned16` maximum value.
function fn(int:Unsigned32 val) {
    int:Unsigned16 max = 65535;

    // Bitwise operations have special typing. Since using `&` with operands
    // of types `int:Unsigned32` and `int:Unsigned16` will result in a value
    // that belongs to `int:Unsigned16`, the static type of `val & max` is 
    // considered to be `int:Unsigned16`, which allows the following.
    int:Unsigned16 res = val & max;
    io:println(res);
}

public function main() {
    // Since `72` belongs to `int:Unsigned32`, it can directly be passed as
    // an argument to the `fn` function.
    fn(72);

    // The cast done in the `intFn` function will be successful since `43543`
    // belongs to `int:Unsigned32`.
    intFn(43543);

    // The cast to `int:Unsigned32` panics since `4294967296` is out of range.
    intFn(4294967296);
}

function intFn(int m) {
    // Since an argument of type `int` cannot be passed to the `fn` function 
    // which only accepts values that belong to `int:Unsigned32`, a cast is attempted
    // before passing `m` as an argument to `fn`. The cast attempt will panic if the 
    // value is out of range for `int:Unsigned32`.
    fn(<int:Unsigned32> m);
}
