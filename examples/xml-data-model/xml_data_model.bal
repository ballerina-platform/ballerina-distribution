import ballerina/io;

public function main() {
    // An XML element. There can be only one root element.
    xml x1 = xml `<book>The Lost World</book>`;
    io:println(x1);

    // An XML text.
    xml x2 = xml `Hello, world!`;
    io:println(x2);

    // An XML comment.
    xml x3 = xml `<!--I am a comment-->`;
    io:println(x3);

    // An XML processing instructions.
    xml x4 = xml `<?target data?>`;
    io:println(x4);

    // Multiple XML items can be combined to form a sequence of XML.
    // The resulting sequence is another XML on its own.
    xml x5 = x1 + x2 + x3 + x4;
    io:println(x5);

}
