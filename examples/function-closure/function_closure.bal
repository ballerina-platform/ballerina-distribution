import ballerina/io;

public function main() {
    string[] names = ["Ana", "Alice", "Bob"];

    // Define a function to modify and return the variable 'names' that are declared outside the scope.
    var addName = function(string value) returns string[] {
        // Access the variable `names` as closure within the `addName` inner function.
        names.push(value);
        return names;
    };

    io:println(addName("James"));
    io:println(names);
}
