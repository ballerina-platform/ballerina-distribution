import ballerina/test;
import ballerina/io;

(any|error)[] outputs = [];
int count = 0;

@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
public function mockPrint(any|error... s) {
    outputs[count] = string.convert(s[0]);
    count += 1;
}

@test:Config
function testFunc() {
    main();
    test:assertEquals(outputs[0], "Create DEPOSITS table status: 0");
    test:assertEquals(outputs[1], "Create WITHDRAWALS table status: 0");
    test:assertEquals(outputs[3], "Commit handler executed.");
    test:assertEquals(outputs[4], "Transaction committed.");
    test:assertEquals(outputs[5], "Insert data into WITHDRAWALS table status: 1");
    test:assertEquals(outputs[6], "Insert data into DEPOSITS table status: 1");
    test:assertEquals(outputs[7], "Retry count: 3");
    test:assertEquals(outputs[8], "Drop table WITHDRAWALS status: 0");
    test:assertEquals(outputs[9], "Drop table DEPOSITS status: 0");
}
