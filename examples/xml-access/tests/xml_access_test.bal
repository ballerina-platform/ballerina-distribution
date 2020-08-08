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

    test:assertEquals(outputs[0], "First name: <fname title=\"Sir\">Arthur</fname>");
    test:assertEquals(outputs[1], "ISBN Code: ");
    test:assertEquals(outputs[2], "Name title: Sir");
    test:assertEquals(outputs[3], "First name (match descendants): <fname title=\"Sir\">Arthur</fname>");
    test:assertTrue(outputs[4].indexOf("<!--Price: $10-->") is int);
    test:assertTrue(outputs[5].indexOf("<!--Price: $10-->") is ());
    test:assertEquals(outputs[6], "Book children in ns: 2019");
    test:assertEquals(outputs[7], "XML sequence filter name: <name>Sherlock Holmes</name>");
    test:assertEquals(outputs[8], "XML sequence filter year: <bar:year xmlns:bar=\"http://ballerina.com/a\">2019</bar:year>");
}
