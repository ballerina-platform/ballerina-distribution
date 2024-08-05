import ballerina/data.csv;
import ballerina/io;

type Book record {|
    string name;
    string author;
|};

string[][] csvArray = [
    ["The Great Gatsby", "F. Scott Fitzgerald", "1925", "Scribner"],
    ["To Kill a Mockingbird", "Harper Lee", "1960", "J. B. Lippincott & Co."]
];

string csvStr = string `name,author,year,publisher
                    The Great Gatsby,F. Scott Fitzgerald,1925,Scribner
                    To Kill a Mockingbird,Harper Lee,1960,J. B. Lippincott & Co.`;

public function main() returns error? {
    // Convert the CSV value of type string array of array into a record array type.
    Book[] book1 = check csv:parseListAsRecordType(csvArray, ["name", "author", "year", "publisher"]);
    io:println(book1);

    // Convert the CSV value of type string into a record array type.
    Book[] book2 = check csv:parseStringToRecord(csvStr);
    io:println(book2);
}
