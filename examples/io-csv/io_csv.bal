import ballerina/io;

public function main() returns error? {
    // Initializes the CSV file paths and content.
    string csvFilePath1 = "./files/csvFile1.csv";
    string csvFilePath2 = "./files/csvFile2.csv";
    string[][] csvContent = [["1", "James", "10000"], ["2", "Nathan", "150000"],
    ["3", "Ronald", "120000"], ["4", "Roy", "6000"],
    ["5", "Oliver", "1100000"]];

    // Writes the given content string[][] to a CSV file.
    check io:fileWriteCsv(csvFilePath1, csvContent);
    // Reads the previously-saved CSV file as a `string[][]`.
    string[][] readCsv = check io:fileReadCsv(csvFilePath1);
    io:println(readCsv);

    // Writes the given content as a stream to a CSV file.
    check io:fileWriteCsvFromStream(csvFilePath2, csvContent.toStream());
    // Reads the previously-saved CSV file as a stream.
    stream<string[], io:Error?> csvStream = check
                                        io:fileReadCsvAsStream(csvFilePath2);
    // Iterates through the stream and prints the content.
    check csvStream.forEach(function(string[] val) {
                              io:println(val);
                          });
}
