// This example imports a module. You can only refer to the public symbols of
// an imported module.
import ballerina/lang.'float;

// Declare an explicit prefix.
import ballerina/io as console;

public function main() {

    // Refer symbols of another module.
    // `math:PI` is a qualified identifier. Note the usage of the module prefix.
    float piValue = float:PI;

    // Use the explicit prefix `console` to invoke a function defined in the `ballerina/io` module.
    console:println(piValue);
}
