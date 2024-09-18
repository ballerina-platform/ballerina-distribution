import ballerina/io;

public function main() {
    map<string> student = {"name": "John", "age": "25"};
    map<anydata> student2 = {"name": "John", "age": "25"};

    // The output will be `true` because the values are considered equal based on their content.
    io:println(student == student2);

    // The output will be `false` because the values are the same.
    io:println(student != student2);
    
    // The output will be `false` because the references are different.
    io:println(student === student2);

    // Assign the value assigned to the `student` variable to the `student3` variable.
    map<string> student3 = student;

    // The output will be `true` because the references are the same.
    io:println(student3 === student);

    // The output will be `false` because the references are the same.
    io:println(student3 !== student);

    int a = 1;
    anydata b = 1;

    // The output will be `true` because the values are the same.
    io:println(a == b);
    // Since values of simple types do not have a storage identity,
    // `===` will evaluate to `true` because the values are the same.
    io:println(a === b);
}
