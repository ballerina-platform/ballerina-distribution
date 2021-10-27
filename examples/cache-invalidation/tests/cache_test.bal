import ballerina/test;

string[] outputs = [];

// This is the mock function, which will replace the real function.
@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
test:MockFunction mock_printLn = new();

public function mockPrint(any|error... val) {
    any|error value = val.reduce(getStringValue, "");
    if (value is error) {
        outputs.push(value.message());
    } else {
        outputs.push(value.toString());
    }
}

@test:Config{}
function testFunc() {
    test:when(mock_printLn).call("mockPrint");

    // Invoking the main function.
    error? output = main();
    if (output is error) {
        test:assertFail("Test failed");
    } else {
        test:assertEquals(outputs[0].toString(), "The existing keys in the cache: [\"key1\",\"key2\",\"key3\"]");
        test:assertEquals(outputs[1].toString(), "The existing keys in after invalidating a given key: [\"key1\",\"key3\"]");
        test:assertEquals(outputs[2].toString(), "The keys after invalidating all the keys: []");
    }
}

function getStringValue(any|error a, any|error b) returns string {
    string aValue = a is error ? a.toString() : a.toString();
    string bValue = b is error ? b.toString() : b.toString();
    return (aValue + bValue);
}
