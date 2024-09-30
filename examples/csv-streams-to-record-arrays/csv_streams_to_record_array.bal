import ballerina/data.csv;
import ballerina/io;

type Book record {
    string name;
    string author;
    decimal price;
    string publishedDate;
};

type BookMinimal record {|
    string name;
    string author;
|};

const csvFilePath = "./files/csv_file.csv";

public function main() returns error? {
    // Write a CSV file.
    check io:fileWriteCsv(csvFilePath, [["name", "author", "price", "publishedDate"],
                                        ["Effective Java", "Joshua Bloch", "45.99", "2018-01-01"],
                                        ["Clean Code", "Robert C. Martin", "37.5", "2008-08-01"]]);

    // Read the CSV file as a byte stream.
    stream<byte[], error?> bookStream = check io:fileReadBlocksAsStream(csvFilePath);

    // Parse as CSV byte stream to an array of records.
    Book[] bookArray = check csv:parseStream(bookStream);
    io:println(bookArray);

    bookStream = check io:fileReadBlocksAsStream(csvFilePath);

    // Parse the CSV byte stream as an array of records with data projection.
    // Here only the fields specified in the target record type (`name` and `author` fields)  
    // are included in the constructed value. 
    BookMinimal[] briefBookArray = check csv:parseStream(bookStream);
    io:println(briefBookArray);
}
