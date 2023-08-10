import ballerina/jballerina.java;

// Returns the `out` field in the `java.lang.System` class.
// `java.lang.System#out` is of the `java.io.PrintStream` type.
public function getStdOut() returns handle = @java:FieldGet {
    name: "out",
    'class: "java/lang/System"
} external;

// Invoke the `println` method on `java.lang.System#out`, 
// which accepts a `java.lang.String` parameter.
public function printInternal(handle receiver, handle strValue) = @java:Method {
    name: "println",
    'class: "java/io/PrintStream",
    paramTypes: ["java.lang.String"]
} external;

public function main() {
    handle stdOut = getStdOut();
    handle str = java:fromString("Hello World");
    printInternal(stdOut, str);
}
