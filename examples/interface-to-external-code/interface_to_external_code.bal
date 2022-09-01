import ballerina/jballerina.java;

// Returns the `out` field in `java.lang.System` class.
// `java.lang.System.out` is of java.io.printString type.
public function getStdOut() returns handle = @java:FieldGet {
    name: "out",
    'class: "java/lang/System"
} external;

// Invoke the `println` method in `java.lang.System.out` which accepts one string parameter.
public function printInternal(handle receiver, handle strValue) = @java:Method {
    name: "println",
    'class: "java/io/PrintStream",
    paramTypes: ["java.lang.String"]
} external;

public function main() {
    handle stdOut = getStdOut();
    printInternal(stdOut, java:fromString("Hello World"));
}
