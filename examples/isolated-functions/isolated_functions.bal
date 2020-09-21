import ballerina/io;

const BALLERINA = "Ballerina";

final string[] & readonly prefixes = ["hello", "greetings", "hello world"];

// An `isolated` function that adds to an array a specific number of
// greeting strings.
// The `greetings` parameter is the array to which greetings have to
// be added. The `count` parameter indicates the number of greetings
// to add.
isolated function addGreetings(string[] greetings, int count) {
    // Call another `isolated` function to build a specific number
    // of greetings.
    string[] builtGreetings = getGreetings(count);

    // Add the greetings returned by the `isolated` function to
    // the mutable array passed as an argument.
    greetings.push(...builtGreetings);
}

// An `isolated` function that accesses global immutable state and
// returns a mutable value.
isolated function getGreetings(int count) returns string[] {
    string[] builtGreetings = [];

    // The `isolated` function can access global state `prefixes` and
    // `BALLERINA` since they are immutable.
    foreach string prefix in prefixes.slice(0, count) {
        builtGreetings.push(prefix + " from " + BALLERINA);
    }

    return builtGreetings;
}

string[] mutableGreetingArray = [];

public function main() {
    // Access global mutable state `mutableGreetingArray`, and
    // pass it as an argument to an `isolated` function.
    // Mutable state can be passed as an argument to an `isolated`
    // function. But this function which accesses global mutable state
    // that is not passed as a parameter, cannot be marked as `isolated`.
    addGreetings(mutableGreetingArray, 2);

    io:println(mutableGreetingArray);
}
