import ballerina/io;

// `Hashable` object type with a method called `hash( )` that returns an integer.
type Hashable object {
    function hash() returns int;
};

function h() returns any {
    var obj = object {
        // Implements the `hash()` method defined in `Hashable` object type.
        function hash() returns int {
            return 42;
        }

        // The object can have other methods.
        function zero() returns int {
            return 0;
        }
    };
    return obj;
}

public function main() {
    // The returned object matches the pattern of the `Hashable` object type,
    // which contains a `hash()` method returning an integer.
    io:println(h() is Hashable);
}
