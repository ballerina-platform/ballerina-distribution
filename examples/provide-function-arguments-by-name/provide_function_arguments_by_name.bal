import ballerina/io;

function foo(int x, int y, int z) {
    io:println("Sum of x, y and z:", x + y + z);
}

public function main() {
    // call `foo` function  using the positional arguments.
    foo(1, 2, 3);

    // call `foo` function using the named arguments in the same order as the parameters of the function definition.
    foo(x = 1, y = 2, z = 3);

    // call `foo` function using the named arguments in a different order from the order of the parameters in the function definition.
    foo(z = 3, y = 2, x = 1);

    // call `foo` function  using a combination of named arguments and positional arguments.
    foo(1, z = 3, y = 2);
}
