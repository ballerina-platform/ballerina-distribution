import ballerina/io;

public function main() returns @tainted error? {
    // Initialize the image paths.
    string imagePath = "./files/ballerina.jpg";
    string imageCopyPath1 = "./files/ballerinaCopy1.jpg";
    string imageCopyPath2 = "./files/ballerinaCopy1.jpg";

    // Read the file content as a byte array using the given file path.
    byte[] bytes = check io:fileReadBytes(imagePath);
    // Write the content that already read to the given destination file.
    check io:fileWriteBytes(imageCopyPath1, bytes);
    io:println("Successfully copied the image as a byte array.");

    // Read the file as a stream of blocks. The default block size is 4KB. Here, the default size is overridden by the value 2KB.
    stream<io:Block> blockStream = check io:fileReadBlocksAsStream(imagePath, 2048);
    // If the file reading was successful, then, the content will be written to the given destination file using the given stream.
    check io:fileWriteBlocksFromStream(imageCopyPath2, blockStream);
    io:println("Successfully copied the image as a stream.");

    // Initialize the text path and the content.
    string textFilePath1 = "./files/textfile1.txt";
    string textFilePath2 = "./files/textfile2.txt";
    string textFilePath3 = "./files/textfile3.txt";
    string textContent = "Ballerina is an open source programming language.";
    string[] lines = ["The Big Bang Theory", "F.R.I.E.N.D.S", "Game of Thrones", "LOST"];

    // Write the given string to a file.
    check io:fileWriteString(textFilePath1, textContent);
    // If the write operation was successful, then, read the content as a string.
    string readContent = check io:fileReadString(textFilePath1);
    io:println(readContent);

    // Write the given array of lines to a file.
    check io:fileWriteLines(textFilePath2, lines);
    // If the write operation was successful, then, perform a read operation to read the lines as an array.
    string[] readLines = check io:fileReadLines(textFilePath2);
    io:println(readLines);

    // Write the given stream of lines to a file.
    check io:fileWriteLinesFromStream(textFilePath3, lines.toStream());
    // If the write operation was successful, then, perform a read operation to read the lines as a stream.
    stream<string> lineStream = check io:fileReadLinesAsStream(textFilePath3);
    // Loop through the stream and print the content.
    _ = lineStream.forEach(function(string val) {
                               io:println(val);
                           });

    // Initialize the JSON file path and content.
    string jsonFilePath = "./files/jsonFile.json";
    json jsonContent = {"Store": {
            "@id": "AST",
            "name": "Anne",
            "address": {
                "street": "Main",
                "city": "94"
            },
            "codes": ["4", "8"]
        }};

    // Write the given JSON to a file.
    check io:fileWriteJson(jsonFilePath, jsonContent);
    // If the write operation was successful, then, perform a read operation to read the JSON content.
    json readJson = check io:fileReadJson(jsonFilePath);
    io:println(readJson);

    // Initialize the XML file path and content.
    string xmlFilePath = "./files/xmlFile.xml";
    xml xmlContent = xml `<book>The Lost World</book>`;

    // Write the given XML to a file.
    check io:fileWriteXml(xmlFilePath, xmlContent);
    // If the write operation was successful, then, perform a read operation to read the XML content.
    xml readXml = check io:fileReadXml(xmlFilePath);
    io:println(readXml);

    // Initialize the CSV file path and content.
    string csvFilePath1 = "./files/csvFile1.csv";
    string csvFilePath2 = "./files/csvFile2.csv";
    string[][] csvContent = [["1", "James", "10000"], ["2", "Nathan", "150000"], ["3", "Ronald", "120000"], ["4", "Roy",
    "6000"], ["5", "Oliver", "1100000"]];

    // Write the given content string[][] to a CSV file.
    check io:fileWriteCsv(csvFilePath1, csvContent);
    // If the write operation was successful, then, perform a read operation to read the CSV content as a string array of arrays.
    string[][] readCsv = check io:fileReadCsv(csvFilePath1);
    io:println(readCsv);

    // Write the given content stream to a CSV file.
    check io:fileWriteCsvFromStream(csvFilePath2, csvContent.toStream());
    // If the write operation was successful, then, perform a read operation to read the CSV content as a stream.
    stream<string[]> csvStream = check io:fileReadCsvAsStream(csvFilePath2);
    // Loop through the stream and print the content.
    _ = csvStream.forEach(function(string[] val) {
                              io:println(val);
                          });
}
