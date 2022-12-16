import ballerina/io;

function add(int x, int y, int z) {
    io:println("Sum of x, y and z:", x + y + z);
}

public function main() {
    // Call the `add` function using the positional arguments.
    add(1, 2, 3);

    // Call the `add` function using the named arguments in the same order as the parameters of the function definition.
    add(x = 1, y = 2, z = 3);

    // Call the `add` function using the named arguments in a different order from the order of the parameters in the function definition.
    add(z = 3, y = 2, x = 1);

    // Call the `add` function using a combination of named arguments and positional arguments.
    add(1, z = 3, y = 2);
}
