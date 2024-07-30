import ballerina/data.csv;
import ballerina/io;

type Book record {
    string name;
    string author;
    string year;
    string publisher;
};

Book[] csvArray = [
    {name: "The Great Gatsby", author: "F. Scott Fitzgerald", year: "1925", publisher: "Scribner"},
    {name: "To Kill a Mockingbird", author: "Harper Lee", year: "1960", publisher: "J. B. Lippincott & Co."},
    {name: "The Catcher in the Rye", author: "J. D. Salinger", year: "1951", publisher: "Little, Brown and Company"},
    {name: "1984", author: "George Orwell", year: "1949", publisher: "Secker & Warburg"}
];

string csvStr = string `name,author,year,publisher
                    The Great Gatsby,F. Scott Fitzgerald,1925,Scribner
                    To Kill a Mockingbird,Harper Lee,1960,J. B. Lippincott & Co.
                    The Catcher in the Rye,J. D. Salinger,1951,Little, Brown and Company
                    1984,George Orwell,1949,Secker & Warburg`;

public function main() returns error? {
    // Convert the CSV value of type record array into a string array of array with projection.
    string[2][2] book1 = check csv:parseRecordAsListType(csvArray, ["name", "author", "year", "publisher"]);
    io:println(book1);

    // Convert the CSV value of type string into a string array of array with projection.
    string[2][2] book2 = check csv:parseStringToList(csvStr);
    io:println(book2);
}
