import ballerina/io;

class EvenNumber {
    int i = 1;

    // `isolated` method.
    isolated function generate() returns int {

        lock {
            // Uses `self` to access mutable field `i`
            // within a `lock` statement.
            return self.i * 2;

        }
    }
}

public function main() {
    EvenNumber e = new;
    int c = e.generate();
    io:println(c);
}
