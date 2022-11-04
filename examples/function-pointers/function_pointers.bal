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
function process(function (int a = num1, int b = num2) returns int func) returns int {
    return func();
}

// Here, the function pointer without default values for function pointer parameters is used as a parameter. 
function operation(function (int, int) returns int func, int v1, int v2) returns int {
    return func(v1, v2);
}

public function main() {
    // The function names `add` and `multiply` serves as a function pointer argument in the
    // call to the `process` and `operation` functions.
    io:println("Add num1 & num2: ", process(add));
    io:println("Multiply num1 & num2: ", process(multiply));
    io:println("Add 1 & 2: ", operation(add, 1, 2));
    io:println("Multiply 3 & 4: ", operation(multiply, 3, 4)); 
}
