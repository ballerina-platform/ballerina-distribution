import ballerina/stringutils;
import ballerina/test;

(string|error)[] outputs = [];
int counter = 0;

// This is the mock function which will replace the real function
@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
public function mockPrint(any|error... s) {
    string outStr = "";
    foreach var str in s {
        outStr = outStr + str.toString();
    }
    lock {
        outputs[counter] = outStr;
        counter += 1;
    }
}

@test:Config{}
function testFunc() {
    // Invoking the main function
    main();
    // The output is in random so we iterate and check if the expected is present
    foreach var x in outputs {
        string value = x.toString();
        if (stringutils:equalsIgnoreCase(value, "[w1 -> w2] i: 100 k: 2.34")) {
            // continue;
        } else if (stringutils:equalsIgnoreCase(value, "[w2 <- w1] iw: 100 kw: 2.34")) {
            // continue;
        } else if (stringutils:equalsIgnoreCase(value, "[w2 -> w1] jw: name=Ballerina")) {
            // continue;
        } else if (stringutils:equalsIgnoreCase(value, "[w1 <- w2] j: name=Ballerina")) {
            // continue;
        } else if (stringutils:equalsIgnoreCase(value, "[w1 ->> w2] i: 100")) {
            // continue;
        } else if (stringutils:equalsIgnoreCase(value, "[w2 <- w1] lw: 100")) {
            // continue;
        } else if (stringutils:equalsIgnoreCase(value, "[w1 ->> w2] successful!!")) {
            // continue;
        } else if (stringutils:equalsIgnoreCase(value, "[w1 -> w3] k: 2.34")) {
            // continue;
        } else if (stringutils:equalsIgnoreCase(value, "Waiting for worker w3 to fetch messages..")) {
            // continue;
        } else if (stringutils:equalsIgnoreCase(value, "[w3 <- w1] mw: 2.34")) {
            // continue;
        } else if (stringutils:equalsIgnoreCase(value, "[w1 -> w3] Flushed!!")) {
            // continue;
        }  else {
            test:assertFail(msg = "The output doesn't contain the expected." + value);
        }
    }
}
