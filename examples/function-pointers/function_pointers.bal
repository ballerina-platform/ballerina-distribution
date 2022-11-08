import ballerina/io;

function add(int v1, int v2) returns int {
    return v1 + v2;
}

function multiply(int v1, int v2) returns int {
    return v1 * v2;
}

int num1 = 10;
int num2 = 100;

// Here, the function pointer with default values for function pointer parameters is used as a parameter. 
function executeWithDefaultValues(function (int a = num1, int b = num2) returns int func) returns int {
    return func();
}

// Here, the function pointer without default values for function pointer parameters is used as a parameter. 
function execute(function (int, int) returns int func, int v1, int v2) returns int {
    return func(v1, v2);
}

public function main() {
    // The `add` and `multiply` function names serve as a function pointer argument in the
    // call to the `executeWithDefaultValues` and `execute` functions.
    io:println("Add num1 & num2: ", executeWithDefaultValues(add));
    io:println("Multiply num1 & num2: ", executeWithDefaultValues(multiply));
    io:println("Add 1 & 2: ", execute(add, 1, 2));
    io:println("Multiply 3 & 4: ", execute(multiply, 3, 4)); 
}
