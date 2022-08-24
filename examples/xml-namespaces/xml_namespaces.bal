import ballerina/io;

public function main() {
    // The `p:e` qualified name, where `http://example.com/` is the namespace name bound to `p`,
    // is expanded into `{http://example.com/}e`.
    xml:Element e = xml `<p:e xmlns:p="http://example.com/"/>`;
    string name = e.getName();
    io:println(name);
}
