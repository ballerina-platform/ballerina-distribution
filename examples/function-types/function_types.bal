import ballerina/io;

// Function type syntax.
type IntFilter function (int num) returns boolean;

// Module-level function definition.
function isEven(int n) returns boolean {
    return n % 2 == 0;
}

public function main() {
    // Type of variable `evenFunc1` is the `IntFilter` function type.
    IntFilter evenFunc1 = isEven;
    io:println(evenFunc1(5));
    io:println(evenFunc1(6));

    // Type of variable `evenFunc1` is `function(int num = 5) returns boolean` function type.
    function (int num = 5) returns boolean evenFunc2 = isEven;

    // Invoke the function with default value defined in the function type.
    io:println(evenFunc2());
    // Invoke the function with the passed argument.
    io:println(evenFunc2(6));

    function (int num = 6) returns boolean evenFunc3 = isolated function(int n = 5) returns boolean {
        return n % 2 == 0;
    };

    // Invoke the function with default value 6 for the parameter `num`.
    io:println(evenFunc3());
}
