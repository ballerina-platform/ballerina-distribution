import ballerina/data.jsondata;
import ballerina/io;

// Define a closed record type to capture the required fields from the JSON content.
type Book record {|
    string name;
    string author;
|};

json jsonContent = {
    "name": "Clean Code",
    "author": "Robert C. Martin",
    "year": 2008,
    "publisher": "Prentice Hall"
};

string jsonStr = string `
{
    "name": "The Pragmatic Programmer",
    "author": "Andrew Hunt, David Thomas",
    "year": 1999,
    "publisher": "Addison-Wesley"
}`;

public function main() returns error? {
    // Based on the expected type, it selectively converts the JSON content to the record type.
    Book book = check jsondata:parseAsType(jsonContent);
    io:println(book);

    // Based on the expected type, it selectively converts the JSON string to the record type.
    Book book2 = check jsondata:parseString(jsonStr);
    io:println(book2);
}
