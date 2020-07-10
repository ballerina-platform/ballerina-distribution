import ballerina/test;

(any|error)[] outputs = [];
int counter = 0;

// This is the mock function that replaces the real function.
@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
public function mockPrint(any|error... s) {
    lock{
        outputs[counter] = s[0];
        counter += 1;
    }
}

@test:Config{}
function testFunc() {
    // Invoke the main function.
    main();
    string[] expected = [];
    expected[0] = "SQ + CB = 737100";
    expected[1] = "Counting done in one second: 0";
    expected[3] = "400";
    expected[4] = "first_field=100 second_field=27 third_field=Hello Moose!!";
    expected[5] = "first field of record --> 100";
    expected[6] = "second field of record --> 27";
    expected[7] = "third field of record --> Hello Moose!!";
    foreach var k in 0...7 {
        if (k == 2) {
            continue;
        }
        test:assertTrue(testExist(expected[k]), msg = expected[k]);
    }
}

function testExist(string text) returns boolean {
    foreach var i in 0...7 {
        if (i == 2) {
            continue;
        }
        string out = outputs[i].toString();
        int? index = out.indexOf(text);
        if (index is int) {
            return true;
        }
    }
    return false;
}
