import ballerina/io;

public function main() {
    map<string> student = {"name": "John", "age": "25"};
    map<anydata> student2 = {"name": "John", "age": "25"};

    // The `==` check evaluates to `true` since the values are considered equal based on the
    // equality of members.
    io:println(student == student2);

    // The `!=` check evaluates to `false` since the values are considered equal based on the
    // equality of members.
    io:println(student != student2);
    
    // The `===` check evaluates to `false` since references are different.
    io:println(student === student2);

    // Assign the value assigned to the `student` variable to the `student3` variable.
    map<string> student3 = student;

    // The `===` check evaluates to `true` since references are same.
    io:println(student3 === student);

    // The `!==` check evaluates to `false` since references are same.
    io:println(student3 !== student);

    // Since values of simple types do not have storage identity 
    // `===` and `==` return the same result, except for floating point values.
    int a = 1;
    anydata b = 1;

    // The output will be `true` because the values are equal.
    io:println(a == b);
    io:println(a === b);

    decimal c = 1.0;
    decimal d = 1.00;

    // The output will be `true` because the values are equal.
    io:println(c == d);
    // The output will be `false` because `c` and `d` are distinct values with different precision.
    io:println(c === d);

    string s1 = "Hello";
    string s2 = "Hello";

    // The string type is a sequence type, but `===` and `==`` return the same result for string comparisons.
    io:println(s1 == s2);
    io:println(s1 === s2);
}
