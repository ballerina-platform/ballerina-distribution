import ballerina/io;

// Usually, it is an error to import a module without using it but if you want to import a module because of what its initialization does,
// then, use `as _` as done in this example.
import ballerina/grpc as _;

// A module can have an `init` function just like an object.
// The initialization of a module ends by calling its `init` function if there is one.
function init() {
    io:println("Hello world");
}
