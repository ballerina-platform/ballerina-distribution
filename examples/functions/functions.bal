import ballerina/io;

// This function definition has two parameters of type `int`.
// `returns` clause specifies type of return value.
function add(int x, int y) returns int {
    int sum = x + y;
    // `return` statement returns a value.
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
    // Invoke the function `add` by passing arguments.
    int sum = add(5, 11);
    // A function with no return type does not need variable assignment.
    print(sum);

    // Invoke the function `sub` with default arguments.
    print(calculateWeight(5));

    // Invoke the function `add` with named arguments.
    print(add(x = 5, y = 6));

    // The return value of the function can be ignored by assigning it to `_`.
    _ = calculateWeight(mass = 5, gForce = 10);
}
