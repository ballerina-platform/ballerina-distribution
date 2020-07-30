import ballerina/test;

(any|error)?[] outputs = [];
int counter = 0;

// This is the mock function which will replace the real function
@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
public function mockPrint(any|error... s) {
    outputs[counter] = s[0];
    counter += 1;
}

@test:Config {}
function testFunc() {
    // Invoking the main function
    main();
    test:assertEquals(outputs[0].toString(), "name=Peter address=50 Bridgeton Lane Tuckerton, NJ 08087");
    test:assertEquals(outputs[1].toString(), "error id 'Jack' not found");
    test:assertEquals(outputs[2].toString(), "name=Bella address=43 Kirkland Ave. North Attleboro, MA 02760");
}
