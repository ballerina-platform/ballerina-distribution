import ballerina/data.csv;
import ballerina/io;

type Book record {
    string name;
    string author;
    decimal price;
    string publishedDate;
};

type BriefBookInfo record {|
    string name;
    string author;
|};

public function main() {
    string csvString = string `name,author,price,publishedDate
                               Effective Java,Joshua Bloch,45.99,2018-01-01
                               Clean Code,Robert C. Martin,37.50,2008-08-01`;

    // Convert the CSV string to a record array
    Book[]|csv:Error bookRecords = csv:parseString(csvString);
    io:println(bookRecords);

    // Convert the CSV string to a record array with data projection.
    // In here only the name and author fields are selected.
    BriefBookInfo[]|csv:Error briefBookRecords = csv:parseString(csvString);
    io:println(briefBookRecords);
}
