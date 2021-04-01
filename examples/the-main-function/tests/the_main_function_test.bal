import ballerina/test;

(any|error)[] outputs = [];
int counter = 0;

// This is the mock function which will replace the real function.
@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
test:MockFunction mock_printLn = new();

public function mockPrint(any|error... s) {
    foreach var val in s {
        outputs[counter] = val;
        counter += 1;
    }
}

@test:Config{}
function testFunc() {
    test:when(mock_printLn).call("mockPrint");

    // Invoking the main function.
    error? e = main(name="Alice", modules=[]);
    test:assertTrue(e is ());
    test:assertExactEquals(outputs[0], "Name: Alice, Age: 18, Year: Freshman");

    // Invoking the main function.
    counter = 0;
    e = main(name = "Alice", age = 20, modules=[]);
    test:assertTrue(e is ());
    test:assertExactEquals(outputs[0], "Name: Alice, Age: 20, Year: Freshman");

    // Invoking the main function.
    counter = 0;
    e = main(name="Alice", year="Sophomore", modules=[]);
    test:assertTrue(e is ());
    test:assertExactEquals(outputs[0], "Name: Alice, Age: 18, Year: Sophomore");

    // Invoking the main function.
    counter = 0;
    e = main(name="Alice", age=20, modules=["Sophomore", "math", "physics"]);
    test:assertTrue(e is ());
    test:assertExactEquals(outputs[0], "Name: Alice, Age: 20, Year: Sophomore, Module(s): [\"math\",\"physics\"]");

    // Invoking the main function.
    counter = 0;
    e = main(name="Ali", modules=[]);
    if (e is error) {
        test:assertExactEquals(e.message(), "InvalidName");
        test:assertExactEquals(e.toString(), "error(\"InvalidName\",message=\"invalid length\")");
    } else {
        test:assertFail(msg = "expected an error");
    }
}
