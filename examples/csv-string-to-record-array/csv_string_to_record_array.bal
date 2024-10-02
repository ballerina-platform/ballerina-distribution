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

public function main() {
    string csvString = string `name,author,price,publishedDate
                               Effective Java,Joshua Bloch,45.99,2018-01-01
                               Clean Code,Robert C. Martin,37.50,2008-08-01`;

    // Parse CSV string to a array of records.
    Book[]|csv:Error bookRecords = csv:parseString(csvString);
    io:println(bookRecords);

    // Parse CSV string to a array of records with data projection.
    // Here only the fields specified in the target record type (`name` and `author` fields)  
    // are included in the constructed value. 
    BookMinimal[]|csv:Error briefBookRecords = csv:parseString(csvString);
    io:println(briefBookRecords);
}
