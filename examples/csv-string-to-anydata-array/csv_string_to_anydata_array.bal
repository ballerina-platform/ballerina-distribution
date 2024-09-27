import ballerina/data.csv;
import ballerina/io;

public function main() returns error? {
    string csvString = string `name,author,price,publishedDate
                               Effective Java,Joshua Bloch,45.99,2018-01-01
                               Clean Code,Robert C. Martin,37.50,2008-08-01`;

    // Parse the CSV string as an array of `string` arrays.
    string[][] bookArray = check csv:parseString(csvString);
    io:println(bookArray);

    // Parse the CSV string to an array of `anydata` arrays.
    anydata[][] bookArray2 = check csv:parseString(csvString);
    io:println(bookArray2);

    // Parse the CSV string to an array of `string` arrays with data projection.
    // Here only the first two headers are extracted to the resulting array,  
    // based on the array member size specified in the expected type. 
    string[][2] bookArray3 = check csv:parseString(csvString);
    io:println(bookArray3);
}
