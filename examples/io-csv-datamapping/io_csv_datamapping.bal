import ballerina/io;


// Defines the record to bind the data.
type Employee record{
    int id;
    string name;
    int salary;
};

public function main() returns error? {
    // Initializes the CSV file path and content.
    string csvFilePath1 = "./files/csvFile1.csv";
    string csvFilePath2 = "./files/csvFile2.csv";
    Employee[] csvContent = [
        {id: 1, name: "James", salary: 10000},
        {id: 2, name: "Nathan", salary: 150000},
        {id: 3, name: "Ronald", salary: 120000},
        {id: 4, name: "Roy", salary: 6000},
        {id: 5, name: "Oliver", salary: 1100000}
    ];

    // Writes the given content `record[]` to a CSV file.
    check io:fileWriteCsv(csvFilePath1, csvContent);
    // Reads the previously-saved CSV file as a `record[]`.
    Employee[] readCsv = check io:fileReadCsv(csvFilePath1);
    io:println(readCsv);

    // Writes the given content as a stream to a CSV file.
    check io:fileWriteCsvFromStream(csvFilePath2, readCsv.toStream());
    // Reads the previously-saved CSV file as a record stream.
    stream<Employee, io:Error?> csvStream = check
                                        io:fileReadCsvAsStream(csvFilePath2);
    // Iterates through the stream and prints the records.
    check csvStream.forEach(function(Employee val) {
                              io:println(val);
                          });
}
