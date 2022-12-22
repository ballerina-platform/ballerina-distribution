import ballerina/io;
 
public function main() {
    table<record {| int id; string name;|}> users = table [{id: 1, name: "John"}, {id: 2, name: "Sam"}];
    // `users` is converted to a JSON array.
    json usersAsJson = users.toJson();
    io:println(usersAsJson is json[]);
    io:println(usersAsJson);
    
    xml book = xml `<book>The Lost World</book>`;
    // `book` is converted to string
    json s = book.toJson();
    io:println(s is string);
    io:println(s);
}
