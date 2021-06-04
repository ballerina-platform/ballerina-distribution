import ballerina/io;

// Anonymous function syntax.
var isOdd = function(int n) returns boolean {
    return n % 2 != 0;
};

// Function type syntax.
type IntFilter function (int n) returns boolean;

// Module-level function definition.
function isEven(int n) returns boolean {
    return n % 2 == 0;
}

public function main() {
    // The `isEven` function  referred as a value.
    IntFilter f = isEven;

    int[] nums = [1, 2, 3];

    // Arrays provide the usual functional methods: 
    // `filter`, `map`, `forEach`, and `reduce`.
    int[] evenNums = nums.filter(f);

    io:println(evenNums);

    // Shorthand syntax when the type is inferred and the body is an expression.
    int[] oddNums = nums.filter(n => n % 2 != 0);

    io:println(oddNums);
}
