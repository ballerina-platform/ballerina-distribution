import ballerina/io;

public function main() {
    // Infer anonymous function.
    // The type of `x` is inferred from the function signature in the expected type.
    function (int) returns int increment = x => x + 1;
    io:println(increment(1));

    // The type of `x` and `y` are inferred from the function signature in the expected type.
    function (int, int) returns int add = (x, y) => x + y;
    io:println(add(1, 2));

    // The explicit anonymous function.
    // The type of the `x` parameter is explicitly defined in the function signature.
    var incrementByTwo = function(int x) returns int => x + 2;
    io:println(incrementByTwo(1));

    // The type of the `x` and `y` parameters are explicitly defined in the function signature.
    var subtract = function(int x, int y) returns int {
        return x - y;
    };
    io:println(subtract(2, 1));
}
