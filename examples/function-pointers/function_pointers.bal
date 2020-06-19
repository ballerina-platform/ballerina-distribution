import ballerina/io;
import ballerina/lang.'int;

public function main() {
    // The function name `test` serves as a function pointer argument in the
    // call to `foo()`. Function names can be thought of as final variables
    // since although you can use it like a regular variable, you cannot
    // modify the value it is associated with.
    io:println("Answer: ", foo(10, test));
    io:println("Answer: ", foo(10, getFunctionPointer()));

    // A function pointer as a variable.
    function (string, int...) returns float f = getFunctionPointer();

    io:println("Answer: ", foo(10, f));
}

// A function pointer as a parameter. A function pointer can be invoked similar
// to how a normal function is invoked.
function foo(int x, function (string, int...) returns float bar)
             returns float {
    return x * bar("2", 2, 3, 4, 5);
}

// A function type as the return type.
function getFunctionPointer() returns
                    (function (string, int...) returns float) {
    // Returning a function pointer.
    return test;
}

function test(string s, int... x) returns float {
    int|error y = 'int:fromString(s);
    float f = 0.0;

    if (y is int) {
        foreach var item in x {
            f += item * 1.0 * y;
        }
    } else {
        panic y;
    }
    return f;
}
