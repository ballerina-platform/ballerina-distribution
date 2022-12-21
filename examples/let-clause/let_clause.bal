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
                     where len1 > 0
                     let int len2 = last.length()
                     where len2 > 0
                     let string name = first + " " + last
                     select name;
 
    io:println(names);
 
    // Let clause supports multiple variable declarations in a single let clause
    // separated by a `,`. Same thing can be written as
    string[] names2 = from var {first, last} in persons
                      let int len1 = first.length(), int len2 = last.length()
                      where len1 > 0 && len2 > 0
                      let string name = first + " " + last
                      select name;
 
    io:println(names2);
}
