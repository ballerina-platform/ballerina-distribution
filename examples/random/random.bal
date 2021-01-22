import ballerina/io;
import ballerina/random;

public function main() {
    // Generate a random decimal number between 0.0 and 1.0.
    float randomDecimal = random:createDecimal();
    io:println("Random decimal number: ", randomDecimal);

    // Generate a random number between the given start(inclusive) and end(exclusive) values.
    int|error randomInteger = random:createIntInRange(1, 100);
    io:println("Random integer number in range: ", randomInteger);
}
