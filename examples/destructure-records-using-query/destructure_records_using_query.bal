import ballerina/io;

type Person record {|
    string first;
    string last;
    anydata...;
|};

public function main() {
    Person[] persons = [
        {first: "Melina", last: "Kodel", "yearOfBirth": 1994},
        {first: "Tom", last: "Riddle", "yearOfBirth": 1926}
    ];

    // A `Person` record is destructured here as a projection with the `first` and `last` fields.
    // `{first, last}` is the mapping binding pattern. It is the same as `{first:first, last:last}`.
    var names = from var {first, last} in persons
                select {first, last};
    io:println(names);

    // Specify the type explicitly before the binding pattern instead of `var`.
    names = from Person {first, last} in persons
                 select {first, last};
    io:println(names);

    // This maps all the remaining fields of the `Person` record other than the field `first`
    // using the rest binding pattern.
    var lastNameAndDOB = from var {first: _, ...restDetail} in persons
                         select restDetail;
    io:println(lastNameAndDOB);
}
