import ballerina/io;

xml:Element e = xml `<p:e xmlns:p="http://example.com/"/>`;

public function main() {
    string name = e.getName();
    io:println(name);
}
