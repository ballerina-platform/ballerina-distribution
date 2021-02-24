import ballerina/io;

public function main() returns @tainted error? {
    // Initialize the CSV file path and content.
    string csvFilePath1 = "./files/csvFile1.csv";
    string csvFilePath2 = "./files/csvFile2.csv";
    string[][] csvContent = [["1", "James", "10000"], ["2", "Nathan", "150000"],
    ["3", "Ronald", "120000"], ["4", "Roy", "6000"],
    ["5", "Oliver", "1100000"]];

    // Write the given content string[][] to a CSV file.
    check io:fileWriteCsv(csvFilePath1, csvContent);
    // If the write operation was successful, then, perform a read operation to read the CSV content as a string array of arrays.
    string[][] readCsv = check io:fileReadCsv(csvFilePath1);
    io:println(readCsv);

    // Write the given content stream to a CSV file.
    check io:fileWriteCsvFromStream(csvFilePath2, csvContent.toStream());
    // If the write operation was successful, then, perform a read operation to read the CSV content as a stream.
    stream<string[], io:Error> csvStream = check
                                        io:fileReadCsvAsStream(csvFilePath2);
    // Loop through the stream and print the content.
    error? e = csvStream.forEach(function(string[] val) {
                              io:println(val);
                          });
}
