import ballerina/test;
import ballerina/io;

(any|error)[] outputs = [];
int counter = 0;

// This is the mock function which will replace the real function
@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
public function mockPrint(any|error... s) {
    string outstr = "";
    foreach var str in s {
        outstr = outstr + io:sprintf("%s", str);
    }
    outputs[counter] = outstr;
    counter += 1;
}

@test:Config {}
function testFunc() {
    // Invoking the main function
    main();

    test:assertEquals(outputs[0], "Score 1: 9.8 Score 2: 9.6 Score 3: 9.5");
}
