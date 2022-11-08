import ballerina/io;

// Tuple type with zero or more strings.
type Names [string...];

// Tuple type with an integer followed by zero or more strings.
type Id [int, string...];

public function main() {
    Names name = ["John", "Michal", "Carl"];
    io:println(name);

    Id id = [1, "id 1", "0026"];

    // The individual elements of this tuple can be accessed using the `id[index]` 
    // member access expression.
    // Tuple indexing starts with zero.
    io:println(id[2]);
}
