import ballerina/test;

(any|error)[] outputs = [];
int counter = 0;

// This is the mock function which will replace the real function.
@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
public function mockPrint(any|error... s) {
    foreach var val in s {
        outputs[counter] = val;
        counter += 1;
    }
}

@test:Config{}
function testFunc() {
    // Invoking the main function.
    error? e = main("Alice");
    test:assertTrue(e is ());
    test:assertExactEquals(outputs[0], "Name: Alice, Age: 18, Year: Freshman");

    // Invoking the main function.
    counter = 0;
    e = main("Alice", 20);
    test:assertTrue(e is ());
    test:assertExactEquals(outputs[0], "Name: Alice, Age: 20, Year: Freshman");

    // Invoking the main function.
    counter = 0;
    e = main("Alice", year="Sophomore");
    test:assertTrue(e is ());
    test:assertExactEquals(outputs[0], "Name: Alice, Age: 18, Year: Sophomore");

    // Invoking the main function.
    counter = 0;
    e = main("Alice", 20, "Sophomore", "math", "physics");
    test:assertTrue(e is ());
    test:assertExactEquals(outputs[0], "Name: Alice, Age: 20, Year: Sophomore, Module(s): [\"math\",\"physics\"]");

    // Invoking the main function.
    counter = 0;
    e = main("Ali");
    if (e is error) {
        test:assertExactEquals(e.message(), "InvalidName");
        test:assertExactEquals(e.toString(), "error(\"InvalidName\",message=\"invalid length\")");
    } else {
        test:assertFail(msg = "expected an error");
    }
}
