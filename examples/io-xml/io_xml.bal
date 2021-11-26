import ballerina/io;

public function main() returns error? {
    // Initializes the XML file path and content.
    string xmlFilePath = "./files/xmlFile.xml";
    xml xmlContent = xml `<book>The Lost World</book>`;

    // Writes the given XML to a file.
    check io:fileWriteXml(xmlFilePath, xmlContent);
    // If the write operation was successful, then, performs a read operation to read the XML content.
    xml readXml = check io:fileReadXml(xmlFilePath);
    io:println(readXml);
}
