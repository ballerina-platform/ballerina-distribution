import ballerina/data.jsondata;
import ballerina/io;

type Book record {
    string name;
    string author;
    int year;
};

public function main() returns error? {
    json jsonContent = {
        "name": "Clean Code",
        "author": "Robert C. Martin",     
        "year": 2008
    };

    // Convert the JSON value to a record type.
    Book book1 = check jsondata:parseAsType(jsonContent);
    io:println(book1);

    string jsonStr = string `
        {
            "name": "Clean Code",
            "author": "Robert C. Martin",
            "year": 2008
        }
    `;

    // Convert the JSON string to a record type.
    Book book2 = check jsondata:parseString(jsonStr);
    io:println(book2);

    byte[] jsonByteArr = jsonStr.toBytes();
    // Convert the JSON byte array to a record type.
    Book book3 = check jsondata:parseBytes(jsonByteArr);
    io:println(book3);

    stream<byte[], error?> byteBlockStream = new(new ByteBlockGenerator(jsonStr));
    // Convert the JSON byte block stream to a record type.
    Book book4 = check jsondata:parseStream(byteBlockStream);
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
