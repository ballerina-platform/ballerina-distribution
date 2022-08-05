import ballerina/io;

// The identifier followed by the `as` keyword is the prefix bound
// to this namespace name.
xmlns "http://example.com" as eg;

xmlns "http://example.com" as ex;

public function main() {
    xml x = xml `<eg:doc>Hello</eg:doc>`;

    boolean b = (x === x.<ex:doc>);
    io:println(b);

    string exdoc = ex:doc;
    io:println(exdoc);
}
