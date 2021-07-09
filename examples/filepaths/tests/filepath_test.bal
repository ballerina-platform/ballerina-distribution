import ballerina/test;
import ballerina/os;

string[] outputs = [];

// This is the mock function, which will replace the real function.
@test:Mock {
    moduleName: "ballerina/io",
    functionName: "println"
}
test:MockFunction mock_printLn = new();

public function mockPrint(any... val) {
    outputs.push(val.reduce(function (any a, any b) returns string => a.toString() + b.toString(), "").toString());
}

boolean isWindows = os:getEnv("OS") != "";

@test:Config {}
function testFunc() returns error? {
    test:when(mock_printLn).call("mockPrint");
    // Invoking the main function.
    check main();

    string absolutePath;
    string filename;
    string parent;
    string normalized;
    string elements;
    string buildPath;
    string relative;

    if (isWindows) {
        absolutePath ="/A/B/C is absolute: false";
        filename ="Filename of /A/B/C: C";
        parent ="Parent of /A/B/C: \\A\\B";
        normalized ="Normalized path of foo/../bar: bar";
        elements ="Path elements of /A/B/C: [\"A\",\"B\",\"C\"]";
        buildPath ="Built path of '/', 'foo', 'bar': \\foo\\bar";
        relative ="Relative path between 'a/b/c' and 'a/c/d': ..\\..\\c\\d";
    } else {
        absolutePath ="/A/B/C is absolute: true";
        filename ="Filename of /A/B/C: C";
        parent ="Parent of /A/B/C: /A/B";
        normalized ="Normalized path of foo/../bar: bar";
        elements ="Path elements of /A/B/C: [\"A\",\"B\",\"C\"]";
        buildPath ="Built path of '/', 'foo', 'bar': /foo/bar";
        relative ="Relative path between 'a/b/c' and 'a/c/d': ../../c/d";
    }
    test:assertEquals(outputs[1], absolutePath);
    test:assertEquals(outputs[2], filename);
    test:assertEquals(outputs[3], parent);
    test:assertEquals(outputs[4], normalized);
    test:assertEquals(outputs[5], elements);
    test:assertEquals(outputs[6], buildPath);
    test:assertEquals(outputs[7], relative);
}
