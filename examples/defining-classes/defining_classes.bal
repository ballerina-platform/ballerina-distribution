import ballerina/io;

public class Counter {
    // `private` means accessible only by code within the `class` definition.
    private int n;

    // `init` method initializes the object.
    public function init(int n = 0) {
        self.n = n;
    }

    public function get() returns int {
        // Methods use `self` to access their object.
        return self.n;

    }

    public function inc() {
        self.n += 1;
    }
}

public function main() {
    // Arguments to `new` are passed as arguments to `init`.
    Counter counter = new (12);

    io:println(counter.get());
}
