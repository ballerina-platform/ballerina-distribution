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

    // Construct stream of byte blocks.
    stream<byte[], error?> byteBlockStream = new(new JsonByteBlock());
    // Convert the JSON byte block stream to a record type.
    Book book4 = check jsondata:parseStream(byteBlockStream);
    io:println(book4);
}

// Defines a class called `JsonByteBlock`, which implements the `next()` method.
// This will be invoked when the `next()` method of the stream gets invoked.
class JsonByteBlock {
    byte[] byteArr = string `
        {
            "name": "Clean Code",
            "author": "Robert C. Martin",
            "year": 2008
        }
    `.toBytes();
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
