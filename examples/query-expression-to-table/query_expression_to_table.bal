import ballerina/io;

type Student record {
    readonly id;
    string firstName;
    string lastName;
    int intakeYear;
    float score;
};

// This is a `table` type with `Student` members uniquely identified by their `id` field.
type StudentTable table<Student> key(id);

public function main() {
    Student s1 = {id: 1, firstName: "Alex", lastName: "George", intakeYear: 2020, score: 1.5};
    Student s2 = {id: 2, firstName: "Ranjan", lastName: "Fonseka", intakeYear: 2021, score: 0.9};
    Student s3 = {id: 3, firstName: "John", lastName: "David", intakeYear: 2022, score: 1.2};
    Student s4 = {id: 4, firstName: "Gorge", lastName: "Fernando", intakeYear: 2023, score: 1.1};

    Student[] studentList = [s1, s2, s3, s4];

    // The `query expression` starts with a `table`.
    // The key specifier `key(id)` specifies the key sequence of the constructed `table`.
    // The result of the `query expression` is a `table`.
    StudentTable|error studentTable = table key(id) from var student in studentList
       // The `where` clause provides a way to perform conditional execution and works similarly to an `if` condition.
       // It can refer to variables bound by the from clause.
       // When the `where` condition evaluates to false, the iteration skips following the clauses.
        where student.intakeYear > 2020
        //The `let` clause binds the variables.
        let float newScore = 1.5
        // The `select` clause is evaluated for each iteration.
        // During the construction of a `table`, each emitted value from the `select` clause is added as a new member.
        select {
            id: student.id,
            firstName: student.firstName,
            lastName: student.lastName,
            intakeYear: student.intakeYear,
            score: newScore
        }
        // The `limit` clause limits the number of output items.
        limit 2;

    io:println("Student Table Information: ", studentTable);

    Student[] duplicateStdList = [s1, s2, s1];

    // Defines an `error` to handle key conflict.
    error onConflictError = error("Key Conflict", message = "cannot insert student");

    StudentTable|error duplicateStdTable = table key(id) from var student in duplicateStdList
            select student
            // `on conflict` clause gets executed when `select` emits a row
            // that has the same key as a row that it emitted earlier.
            // It gives `onConflictError` error if there is a key conflict.
            on conflict onConflictError;

    io:println(duplicateStdTable);
}
