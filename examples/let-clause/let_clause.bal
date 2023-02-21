import ballerina/io;

type Student record {|
    string first;
    string last;
    int mathematics;
    int english;
|};

public function main() {
    Student[] students = [
        {first: "Melina", last: "Kodel", mathematics: 79, english: 83},
        {first: "Tom", last: "Riddle", mathematics: 69, english: 45}
    ];

    int[] names = from var student in students
                  // The `let` clause binds the variables.
                  let int sum = (student.mathematics + student.english)
                  where sum > 0
                  let int avg = sum / 2
                  select avg;

    io:println(names);

    // The `let` clause supports multiple variable declarations separated by `,`.
    names = from var student in students
                   let int sum = (student.mathematics + student.english), int avg = sum / 2
                   where sum > 0
                   select avg;

    io:println(names);
}
