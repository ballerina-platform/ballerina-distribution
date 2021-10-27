import ballerina/io;

// An `isolated` object’s mutable state is `isolated` from the
// rest of the program.
isolated class Counter {
    // `n` is a mutable field.
    private int n = 0;

    isolated function get() returns int {
        lock {
            // `n` can only be accessed using `self`.
            return self.n;

        }
    }

    isolated function inc() {
        lock {
            self.n += 1;
        }
    }
}

public function main() {
    // The object’s mutable state is accessible only via the
    // object itself making it an “isolated root”.
    Counter c = new;

    c.inc();
    int v = c.get();
    io:println(v);
}
