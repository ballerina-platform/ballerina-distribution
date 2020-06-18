import ballerina/io;

type Student record {
    string firstName;
    string lastName;
    int intakeYear;
    float score;
};

public function main() {

    Student s1 = {firstName: "Alex", lastName: "George", intakeYear: 2020, score: 1.5};
    Student s2 = {firstName: "Ranjan", lastName: "Fonseka", intakeYear: 2020, score: 0.9};
    Student s3 = {firstName: "John", lastName: "David", intakeYear: 2022, score: 1.2};
    Student s4 = {firstName: "Gorge", lastName: "Fernando", intakeYear: 2021, score: 1.1};

    Student[] studentList = [s1, s2, s3, s4];

    //The `from` clause works similarly to a `foreach` statement.
    //It can be used to iterate any iterable value.
    //The `students` is the concatenated string of the query expression results.
    string students = from var student in studentList
       //The `where` clause provides a way to perform conditional execution and works similarly to an `if` condition.
       //It can refer to variables bound by the from clause.
       //When the `where` condition evaluates to false, the iteration skips the following clauses.
       where student.score >= 1
       //The concatenation of the `select` clause is evaluated for each iteration.
       select student.firstName + " " + student.lastName + ", ";

    io:println(students);
}
