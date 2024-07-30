import ballerina/data.csv;
import ballerina/io;

type Book record {
    string name;
    string author;
    int year;
};

Book[] csvArray = [
    {name: "The Great Gatsby", author: "F. Scott Fitzgerald", year: 1925},
    {name: "To Kill a Mockingbird", author: "Harper Lee", year: 1960}
];

string csvStr = string `name,author,year
                    The Great Gatsby,F. Scott Fitzgerald,1925
                    To Kill a Mockingbird,Harper Lee,1960`;

public function main() returns error? {
    // Convert the CSV value of type record array into a string or int array of array type.
    (string|int)[][] book1 = check csv:parseRecordAsListType(csvArray, ["name", "author", "year"]);
    io:println(book1);

    // Convert the CSV value of type string into a json array of array type.
    json[][] book2 = check csv:parseStringToList(csvStr);
    io:println(book2);

    byte[] csvByteArr = csvStr.toBytes();
    // Convert the CSV value of type byte array into a tuple array type.
    [string...][] book3 = check csv:parseBytesToList(csvByteArr);
    io:println(book3);

    stream<byte[], error?> byteBlockStream = new (new ByteBlockGenerator(csvStr));
    // Convert the CSV value of type block stream into a anydata array of array type.
    anydata[][] book4 = check csv:parseStreamToList(byteBlockStream);
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
