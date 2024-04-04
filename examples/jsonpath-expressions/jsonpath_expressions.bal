import ballerina/data.jsondata;
import ballerina/io;

json books = [
    {
        title: "The Great Gatsby",
        author: "F. Scott Fitzgerald",
        price: 100,
        year: 1925
    },
    {
        title: "To Kill a Mockingbird",
        author: "Harper Lee",
        price: 72.5,
        year: 1960
    },
    {
        title: "1984",
        author: "George Orwell",
        price: 90,
        year: 1949
    }
];

public function main() returns error? {
    // JSON path expression to get the list of titles in the books array.
    json titles = check jsondata:read(books, `$..title`);
    io:println(titles);

    // JSON path expression to get the list of publised years for the 
    // books that have price value more than 80.
    json years = check jsondata:read(books, `$..[?(@.price > 80)].year`);
    io:println(years);

    // JSON path expression to get the total summation of the books.
    json totalSum = check jsondata:read(books, `$..price.sum()`);
    io:println(totalSum);
}
