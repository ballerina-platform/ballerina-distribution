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

    // A `Person` record is destructured here, as a
    // projection with `first` and `last` fields.
    // `{first: f, last: l}` is the `binding pattern`.
    var names1 = from var {first: f, last: l} in persons
                select {first: f, last: l};


    io:println(names1);

    // The same can be simplified as this.
    var names2 = from var {first, last} in persons
                select {first, last};


    io:println(names2);
}
