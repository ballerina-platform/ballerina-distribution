import ballerina/test;

(any|error)[] outputs = [];

// This is the mock function, which will replace the real function.
@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
public function mockPrint(any|error... s) {
    foreach var elem in s {
        outputs.push(elem);
    }
}

@test:Config {}
function testFunc() {
    // Calling the main function with an empty args array.
    main();
    test:assertEquals(outputs[0], "PI: ");
    test:assertEquals(outputs[1], 3.14159);
    test:assertEquals(outputs[2], "Distance of a light year (meters): ");
    test:assertEquals(outputs[3], 9454240512000000);
    map<string> output1 = {  "user": "Ballerina", "ID": "1234" };
    test:assertEquals(outputs[4], output1);
    map<map<string>> output2 = { "data": output1, "data2": { "user": "WSO2" } };
    test:assertEquals(outputs[5], output2);
    test:assertEquals(outputs[6], "Ballerina");
}
