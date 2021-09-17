import ballerina/io;

type Person record {
 string first;
 string last;
 int yearOfBirth;
};

public function main() {
    Person[] persons = [
        {first: "Melina", last: "Kodel", yearOfBirth: 1994},
        {first: "Tom", last: "Riddle", yearOfBirth: 1926}
    ];

    string[] names = from var {first, last} in persons
                     // The `let` clause binds the variables.
                     let int len1 = first.length()
                     // The `where` clause provides a way to perform conditional execution.
                     where len1 > 0

                     let int len2 = last.length()
                     where len2 > 0
                     let string name = first + " " + last
                     select name;
                     
    io:println(names);
}
