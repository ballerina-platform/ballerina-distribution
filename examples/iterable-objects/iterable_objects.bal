import ballerina/io;

// A class that is a subtype of `Iterator<int, ()>`.
class ArrayIterator {
    private int[] integers = [0, 1, 1, 2, 3, 5, 8, 13, 21, 34];
    private int cursor = -1;

    // `next` method which generates the sequence of values of type `int`.
    public isolated function next() returns record {| int value; |}? {
        self.cursor += 1;
        if self.cursor < self.integers.length() {
            record {| int value; |} nextVal = 
                {value: self.integers[self.cursor]};
            return nextVal;
        } else if self.cursor > self.integers.length() {
            panic error("Index out of range");
        }
        return ();
    }
}

//  A class that is a subtype of `Iterable<int, ()>`.
class IteratorGenerator {
    *object:Iterable;
    // The `iterator()` method should return a subtype of `Iterator<int, ()>`.
    public function iterator() returns object {
        public isolated function next() returns record {| int value; |}?;
        } {
        return new ArrayIterator();
    }
}

// A class that is a subtype of `Iterator<int, error?>`.
// This class can create objects that can return error on some cases for next method.
class ArrayIteratorWithError {
    private int[] integers = [0, 12, 21, 45];
    private int cursor = -1;

    // `next` method which generates the sequence of values of type `int`.
    public isolated function next() returns record {| int value; |}|error? {
        self.cursor += 1;
        if self.cursor < self.integers.length() {
            int nextValue = self.integers[self.cursor];
            if nextValue < 0 {
                return error("Negative value recieved");
            }
            record {| int value; |} nextVal = {value: nextValue};
            return nextVal;
        }
        return ();
    }
}

// A class that is a subtype of `Iterable<int, error?>`.
// The `next` method of the iterator object returned by this class 
// may return an error.
class IteratorGeneratorWithError {
    *object:Iterable;
    // The `iterator()` method should return a new `Iterator<T,()>`.
    public function iterator() returns object {
        public isolated function next() returns record {| int value; |}|error?;
       } {
        return new ArrayIteratorWithError();
    }
}

public function main() {
    io:println("Elements of IteratorGenerator");
    IteratorGenerator itrGen = new;
    int i = 0;
    foreach var item in itrGen {
        i += 1;
        io:println("Element ", i, ": ", item);
    }

    io:println("Elements of IteratorGeneratorWithError");
    i = 0;
    IteratorGeneratorWithError itarableWithError = new;

    // An iterable object can be used in a query expression.
    int[]|error integers = from var item in itarableWithError select item;
    if integers is error {
        panic integers;
    } else {
        foreach var item in integers {
            i += 1;
            io:println("Element ", i, ": ", item);
        }
    }
}
