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

    // Construct stream of byte blocks.
    stream<byte[], error?> byteBlockStream = new(new XmlByteBlock());
    // Convert the XML byte block stream to a record type.
    Book book4 = check xmldata:parseStream(byteBlockStream);
    io:println(book4);
}

// Defines a class called `XmlByteBlock`, which implements the `next()` method.
// This will be invoked when the `next()` method of the stream gets invoked.
class XmlByteBlock {
    byte[] byteArr = string `<book>
        <id>10024</id>
        <title>Clean Code</title>
        <author>Robert C. Martin</author>
    </book>`.toBytes();
    int i = 0;

    public isolated function next() returns record {|byte[] value;|}|error? {
        if self.i >= self.byteArr.length() {
            return;
        }
        int startIndex = self.i;
        int endIndex = startIndex + 3;
        self.i = endIndex;
        if endIndex >= self.byteArr.length() {
            endIndex = self.byteArr.length() - 1;
        }
        return {value: self.byteArr.slice(startIndex, self.i)};
    }
}
