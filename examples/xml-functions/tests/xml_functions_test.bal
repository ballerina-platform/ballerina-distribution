import ballerina/test;

string[] outputs = [];

// This is the mock function which will replace the real function
@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
public function mockPrint(any|error... val) {
    outputs.push(val.reduce(function (any|error a, any|error b) returns string => a.toString() + b.toString(), "").toString());
}

@test:Config {}
function testFunc() {
    // Invoking the main function.
    main();

    test:assertEquals(outputs[0], "Element name: name");
    test:assertEquals(outputs[1], "Concat: Hello, World!<name>Book1</name><!--some comment-->");
    test:assertEquals(outputs[2], "Equals: true");
    test:assertEquals(outputs[3], "Length: 3");
    test:assertEquals(outputs[4], "Subsequence: <!--some comment-->");
    test:assertEquals(outputs[5], "All XML elements: <name>Book1</name>");
    test:assertEquals(outputs[6], "Child elements set: <book>Hello, World!<name>Book1</name><!--some comment--></book>");
    test:assertEquals(outputs[7], "Stripped: Hello, World!<name>Book1</name>");
}
