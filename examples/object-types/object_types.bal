import ballerina/io;

// This is the definition of `Hashable` object type
type Hashable object {
    function hash() returns int;
};

function h() returns any {
    var obj = object {
        // This is the implementation of method `hash()` that defined in `Hashable` object type,
        // like implementing an interface
        function hash() returns int {
            return 42;
        }

        // It can have other methods
        function zero() returns int {
            return 0;
        }
    };
    return obj;
}

public function main() {
    // output is true
    io:println(h() is Hashable);
}
