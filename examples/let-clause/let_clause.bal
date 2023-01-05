import ballerina/io;

type Person record {|
    string first;
    string last;
    int maths;
    int english;
|};

public function main() {
    Person[] persons = [
        {first: "Melina", last: "Kodel", maths: 79, english: 83},
        {first: "Tom", last: "Riddle", maths: 69, english: 45}
    ];

    int[] names = from var person in persons
                  // The `let` clause binds the variables.
                  let int sum = (person.maths + person.english)
                  where sum > 0
                  let int avg = sum / 2
                  select avg;

    io:println(names);


    // `let` clause supports multiple variable declarations separated by `,`.
    int[] names2 = from var person in persons
                   let int sum = (person.maths + person.english), int avg = sum / 2
                   where sum > 0
                   select avg;

    io:println(names2);
}
