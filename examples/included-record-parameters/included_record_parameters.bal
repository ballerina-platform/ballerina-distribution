import ballerina/io;

type Options record {|
    boolean verbose = false;
    string? outputFile = ();
|};

// `foo` has a string parameter `inputFile` and an included record parameter of the
// `Options` record type.
function foo(string inputFile, *Options options) {
    io:println("Input File:", inputFile);
    io:println("Options:", options);
}

public function main() {
    // Call `foo()` by directly passing a value of the `Options` record type.
    foo("file.txt", {verbose: true});

    // Pass named arguments having the same names as the fields in the `Options` record.
    foo("file.txt", verbose = true);
}
