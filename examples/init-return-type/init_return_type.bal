import ballerina/io;

// Defines a `class` called `File`.
class File {

    string path;
    string contents;
    // The `init()` method is used to initialize the `object` when creating a new `object`.
    function init(string p, string? c) returns error? {
        self.path = p;
        self.contents = check c.ensureType(string);
        return;
    }

}

public function main() returns error? {
    // `new` returns the newly-constructed `File` object.
    File f = check new File("test.txt", "Hello World");

    io:println(f.contents);
    return;
}
