import ballerina/io;

// This function definition has two parameters of type `int`.
// The `returns` clause specifies the type of the return value.
function add(int x, int y) returns int {
    int sum = x + y;
    // The `return` statement returns a value.
    return sum;
}

// The function parameters can have default values.
function calculateWeight(decimal mass, decimal gForce = 9.8) returns decimal {
    return mass * gForce;
}

// The function returns `nil`.
function print(anydata data) {
    io:println(data);
}

public function main() {
    // Invoke the function `add` by passing the arguments.
    int sum = add(5, 11);
    // A function with no return type does not need a variable assignment.
    print(sum);

    // Invoke the `calculateWeight` function with the default arguments.
    print(calculateWeight(5));

    // Invoke the `add` function with the named arguments.
    print(add(x = 5, y = 6));

    // The return value of the function can be ignored by assigning it to `_`.
    _ = calculateWeight(mass = 5, gForce = 10);
}
