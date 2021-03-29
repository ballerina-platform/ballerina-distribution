import ballerina/io;

type SampleError error<Foo>;

type InvalidIdError error<InvalidIdDetail>;

type Foo record {|
    string message?;
    error cause?;
    boolean fatal;
|};

type InvalidIdDetail record {|
    string message?;
    error cause?;
    string id;
|};

public function main() {
    [string, string] v1 = ["Sample String", "Sample String 2"];
    Foo v2 = {message: "A", fatal: false};
    InvalidIdError e3 = error InvalidIdError("Invalid Error", id = "33456");
    SampleError e2 = error SampleError("Sample Error", message = "Fatal",
                                       fatal = true);
    error e1 = error("Generic Error", message = "Failed");

    basicMatch(v1);
    basicMatch(v2);
    basicMatch(e1);
    basicMatch(e2);
    basicMatch(e3);
}

function basicMatch(any|error v) {
    match v {
        [var tVar1, var tVar2] => {
            io:println("Matched a value with a tuple shape");
        }
        {message: var a, fatal: var b} => {
            io:println("Matched a value with a record shape");
        }
        // If the 'v' variable contains an `error` values of the shape that matches the
        // `InvalidIdError`, it will be matched to the `InvalidIdError` indirect
        // error match pattern.
        error InvalidIdError(id = var a) => {
            io:println("Matched `InvalidError` id=", a);
        }
        // If a rest binding pattern is used, the error details that are not
        // matched will be recorded in a map.
        error SampleError("Sample Error", message = var a, ...var b) => {
            io:println("Matched an error value : ", string
            `message: ${a is string ? a : ""}, rest detail: ${b.toString()}`);
        }
        // If the `v` variable contains an `error` value, it will be matched
        // to this pattern and the reason string and the detail record will be
        // destructed within the pattern block.
        error("Generic Error", message = var a) => {
            io:println("Matched an error value : ",
            string `message: ${a is string ? a : ""}`);
        }
    }
}
