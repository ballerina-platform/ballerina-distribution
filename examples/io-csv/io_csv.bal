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
    // Reads the previously saved CSV file in csvFilePath1 as a string[][], 
    // if the write operation was successful.
    string[][] readCsv = check io:fileReadCsv(csvFilePath1);
    io:println(readCsv);

    // Writes the given content as a stream to a CSV file.
    check io:fileWriteCsvFromStream(csvFilePath2, csvContent.toStream());
    // Reads the CSV file in csvFilePath2 as a stream,
    // if the previous step of writing a CSV file from stream was successful.
    stream<string[], io:Error?> csvStream = check
                                        io:fileReadCsvAsStream(csvFilePath2);
    // Iterates through the stream and prints the content.
    check csvStream.forEach(function(string[] val) {
                              io:println(val);
                          });
}
