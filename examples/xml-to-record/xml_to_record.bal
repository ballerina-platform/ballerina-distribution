import ballerina/data.xmldata;
import ballerina/io;

type Book record {
    int id;
    string title;
    string author;
};

public function main() returns error? {
    xml xmlData = xml `<book>
        <id>10024</id>
        <title>Clean Code</title>
        <author>Robert C. Martin</author>
    </book>`;

    // Convert the XML value to a record type.
    Book book1 = check xmldata:parseAsType(xmlData);
    io:println(book1);

    string xmlStr = string `<book>
        <id>10024</id>
        <title>Clean Code</title>
        <author>Robert C. Martin</author>
    </book>`;

    // Convert the XML string to a record type.
    Book book2 = check xmldata:parseString(xmlStr);
    io:println(book2);

    byte[] xmlByteArr = xmlStr.toBytes();
    // Convert the XML byte array to a record type.
    Book book3 = check xmldata:parseBytes(xmlByteArr);
    io:println(book3);

    stream<byte[], error?> byteBlockStream = new(new ByteBlockGenerator(xmlStr));
    // Convert the XML byte block stream to a record type.
    Book book4 = check xmldata:parseStream(byteBlockStream);
    io:println(book4);
}

// Defines a class called `ByteBlockGenerator`, which implements the `next()` method.
// This will be invoked when the `next()` method of the stream gets invoked.
class ByteBlockGenerator {
    private int index = 0;
    private final byte[] byteArr;
    private final int arraySize;

    public function init(string data) {
        self.byteArr = data.toBytes();
        self.arraySize = self.byteArr.length();
    }

    public isolated function next() returns record {|byte[] value;|}|error? {
        if self.index >= self.arraySize {
            return;
        }
        int startIndex = self.index;
        self.index = startIndex + 4 > self.arraySize ? self.arraySize : startIndex + 3;
        return {value: self.byteArr.slice(startIndex, self.index)};
    }
}
