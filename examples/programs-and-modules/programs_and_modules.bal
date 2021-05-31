// This import declaration binds the prefix `io` to the `ballerina/io` module. 
// The prefix by default comes form the last part of the module name.
// The `ballerina` org name is reserved for the standard library modules.
import ballerina/io;

// `main` function is the program entry point. 
// `public` makes function visible outside the module.
public function main() {
    // Here `io:println` means function `println` is in the module bound to prefix `io`.
    io:println("Hello, World!");

}
