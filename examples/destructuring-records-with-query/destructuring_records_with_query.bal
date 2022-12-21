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
    // `{first, last}` is the mapping binding pattern. it is same as `{first:first, last:last}`
    var names = from var {first, last} in persons
                select {first, last};
    io:println(names);

    // Explicitly specify the type before the binding pattern instead of `var`.
    var names2 = from Person {first, last} in persons
                 select {first, last};
    io:println(names2);

    // This maps all the remaining fields of `Person` record other than the field `first`
    // using rest binding pattern.
    var lastNameAndDOB = from var {first: _, ...restDetail} in persons
                         select restDetail;
    io:println(lastNameAndDOB);
}
