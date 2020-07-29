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

    string out1 = "a1: true 0.4";
    string out2 = "b1: true b2: 0.4";
    string out3 = "c1: Ballerina c2: 4 c3: 6.7";
    string out4 = "d1: Ballerina d2: 34 d3: true d4: 6.7";
    string out5 = "e1: Ballerina 3 true 34 5.6 45";
    string out6 = "f1: Ballerina f2: 3 f3: true f4: 34 f5: 5.6 f6: 45";
    string out7 = "g1: Ballerina g2: 3.4 g3: 456";

    test:assertEquals(outputs[0], out1);
    test:assertEquals(outputs[1], out2);
    test:assertEquals(outputs[2], out3);
    test:assertEquals(outputs[3], out4);
    test:assertEquals(outputs[4], out5);
    test:assertEquals(outputs[5], out6);
    test:assertEquals(outputs[6], out7);
}
