import ballerina/test;
import ballerina/io;

function add(int v1, int v2) returns int {
    return v1 + v2;
}

function multiply(int v1, int v2) returns int {
    return v1 * v2;
}

// Here, the function pointer is used as a parameter. A function pointer can be invoked similar
// to how a normal function is invoked.
function process(function (int, int) returns int func, int v1, int v2) returns int {
    return func(v1, v2);
}

public function main() {
    // The function name `add` serves as a function pointer argument in the
    // call to the `process()` function. Function names can be thought of as final variables
    // since although you can use them like a regular variable, you cannot
    // modify the values they are associated with.
    io:println("Process Add 1, 2: ", process(add, 1, 2));
    io:println("Process Multiply 3, 4: ", process(multiply, 3, 4)); 
}
(any|error)[] outputs = [];

// This is the mock function which will replace the real function
@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
public function mockPrint(any|error... s) {
    foreach var entry in s {
        outputs.push(entry);
    }
}

@test:Config {}
function testFunc() {
    // Invoking the main function
    main();
    test:assertEquals(outputs[0], "Process Add 1, 2: ");
    test:assertEquals(outputs[1], 3);
    test:assertEquals(outputs[2], "Process Multiply 3, 4: ");
    test:assertEquals(outputs[3], 12);
}
