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

    string out1 = "Name: Jack Smith Age: 23 Address: 380 Lakewood Dr. Desoto, TX 75115";
    string out2 = "Latitude: 37.773972 Longitude: -122.431297";
    string out3 = "Event Id: E335 Score 1: 9.8 Score 2: 9.6 Score 3: 9.5";

    test:assertEquals(outputs[0], out1);
    test:assertEquals(outputs[1], out2);
    test:assertEquals(outputs[2], out3);
}
