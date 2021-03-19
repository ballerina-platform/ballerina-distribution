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

    // Read the previously written CSV from the 'csvFile1.csv' file as a stream.
    stream<string[], io:Error> csvStream1 = check
                                        io:fileReadCsvAsStream(csvFilePath1);
    // Write the given streaming content to a CSV file.
    check io:fileWriteCsvFromStream(csvFilePath2, csvStream1);

    // Verify the streaming write operation by reading 'csvFile2.csv' as a stream.
    stream<string[], io:Error> csvStream2 = check
                                        io:fileReadCsvAsStream(csvFilePath2);
    // Loop through the stream and print the content.
    error? e = csvStream2.forEach(function(string[] val) {
                              io:println(val);
                          });

}
