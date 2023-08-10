import ballerina/io;

// Defines a class called `EvenNumberGenerator`, which implements the `next()` method.
// This will be invoked when the `next()` method of the stream gets invoked.
class EvenNumberGenerator {
    int i = 0;
    public isolated function next() returns record {|int value;|}|error? {
        self.i += 2;
        return {value: self.i};
    }
}

public function main() {
    EvenNumberGenerator evenGen = new ();

    // Creates a `stream` passing an `EvenNumberGenerator` object to the `stream` constructor.
    stream<int, error?> evenNumberStream = new (evenGen);

    var evenNumber = evenNumberStream.next();

    if (evenNumber !is error?) {
        io:println("Retrieved even number: ", evenNumber.value);
    }
}
