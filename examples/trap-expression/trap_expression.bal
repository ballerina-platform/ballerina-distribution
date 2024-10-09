import ballerina/io;

function hereBeDragons() returns int {
    // Trigger a panic deep within the call stack. 
    alwaysPanic();
}

// Return type `never` indicate that this function will never return normally. That is it will always panic
function alwaysPanic() returns never {
    panic error("deep down in the code");
}

public function main() {
    // Division by 0 trigger a panic  
    int|error result = trap 1 / 0;
    if result is error {
        io:println("Error: ", result);
    }
    // This will tigger a panic deep within the call stack and we'll trap it here
    int|error result2 = trap hereBeDragons();
    if result2 is error {
        io:println("Error: ", result2);
    }
}
