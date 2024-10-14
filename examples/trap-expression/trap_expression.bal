import ballerina/io;

function hereBeDragons() returns int {
    // Trigger a panic deep within the call stack. 
    alwaysPanic();
}

// Return type `never` indicate that this function will never return normally. I.e., it will always panic.
function alwaysPanic() returns never {
    panic error("deep down in the code");
}

public function main() {
    // Division by 0 triggers a panic. 
    int|error result = trap 1 / 0;
    if result is error {
        io:println("Error: ", result);
    }
    // Calling the `hereBeDragons` function triggers a panic deep within the call stack, which is trapped here.
    int|error result2 = trap hereBeDragons();
    if result2 is error {
        io:println("Error: ", result2);
    }
    // This will trigger a panic which is not trapped. Thus it will terminate the program.
    int result3 = hereBeDragons();
    io:println("Result: ", result3);
}
