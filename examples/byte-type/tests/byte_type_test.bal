import ballerina/test;

(any|error)[] outputs = [];
int count = 0;

// This is the mock function which will replace the real function
@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
public function mockPrint(any|error... s) {
    outputs[count] = s[0];
    count += 1;
}

@test:Config {}
function testFunc() {
    // Invoking the main function
    main();
    test:assertEquals(outputs[0], 12);
    byte[] byteArray1 = [5, 24, 56, 243];
    test:assertEquals(outputs[1], byteArray1);
    byte[] byteArray2 = [174, 238, 205, 239, 171, 205, 18, 52, 85, 103, 136, 136, 34];
    test:assertEquals(outputs[2], byteArray2);
    byte[] byteArray3 = [104, 101, 108, 108, 111, 32, 98, 97, 108, 108, 101, 114, 105, 110, 97, 32, 33, 33, 33];
    test:assertEquals(outputs[3], byteArray3);
}
