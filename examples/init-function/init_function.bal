import ballerina/io;

// Uninitialized integer variable `value`.
int value;

// Uninitialized final string variable `name`.
final string name;

function init() returns error? {
    // Initialize the variable `value` to 5.
    value = 5;
    // Initialize the final variable greeting to `James`.
    name = "James";
    
    if value > 3 {
        // The initialization will fail with this error message.
        return error("Value should less than 3");
    }
}

public function main() {
    // This will not be executed because the init function returns an error.
    io:println(name);
}
