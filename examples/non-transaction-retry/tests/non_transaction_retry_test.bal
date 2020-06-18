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
    test:assertEquals(outputs[0], "start attempt 1:error, attempt 2:error, attempt 3:result returned end.");
}
