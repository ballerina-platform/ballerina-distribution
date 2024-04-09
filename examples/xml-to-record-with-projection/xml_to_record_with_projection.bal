import ballerina/data.xmldata;
import ballerina/io;

// Define a closed record type to capture the required elements and attributes from the XML data.
type Book record {|
    string name;
    string author;
|};

xml xmlData = xml `
<book>
    <name>Clean Code</name>
    <author>Robert C. Martin</author>
    <year>2008</year>
    <publisher>Prentice Hall</publisher>
</book>`;

string xmlStr = string `
<book>
    <name>Clean Code</name>
    <author>Robert C. Martin</author>
    <year>2008</year>
    <publisher>Prentice Hall</publisher>
</book>`;

public function main() returns error? {
    // Based on the expected type, it selectively converts the XML data to the record type.
    Book book = check xmldata:parseAsType(xmlData);
    io:println(book);

    // Based on the expected type, it selectively converts the XML string to the record type.
    Book book2 = check xmldata:parseString(xmlStr);
    io:println(book2);
}
