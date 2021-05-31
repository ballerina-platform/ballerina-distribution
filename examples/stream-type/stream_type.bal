class EvenNumberGenerator {
    int i = 0;
    public isolated function next() returns record {| int value; |}|error? {
        self.i += 2;
        return { value: self.i };
    }
}

public function main() {
    EvenNumberGenerator evenGen = new();
    // Creates a `stream` passing an `EvenNumberGenerator` object
    // to the `stream` constructor.
    stream<int, error?> evenNumberStream = new(evenGen);
}
