import ballerina/io;

type Student record {|
    readonly int id;
    string name;
    int score;
|};

public function main() {
    error onConflictError = error("Key Conflict", message = "record with same key exists.");

    table<Student> students = table [
            {id: 1, name: "John", score: 100},
            {id: 2, name: "Jane", score: 150},
            {id: 1, name: "John", score: 200}
        ];

    // Result of the following will be an error since key `John` is be duplicated
    map<int>|error studentScores = map from var {name, score} in students
                                   select [name, score]
                                   on conflict onConflictError;

    io:println(studentScores);

    // Value `100` of the key `John` will be replaced by the second occorence value `200`
    map<int> lastRoundScore = map from var student in students
                              select [student.name, student.score]
                              on conflict ();

    io:println(lastRoundScore);

    // Result of the following will be an error since key `1` is be duplicated
    table<Student> key(id)|error studentScoresTable = table key(id) from var student in students
                                                      select student
                                                      on conflict onConflictError;

    io:println(studentScoresTable);
}
