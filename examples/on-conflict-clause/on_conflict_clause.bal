import ballerina/io;

type Student record {|
    readonly int id;
    string name;
    int score;
|};

public function main() {
    table<Student> students = table [
            {id: 1, name: "John", score: 100},
            {id: 2, name: "Jane", score: 150},
            {id: 1, name: "John", score: 200}
        ];

    // The result of the following will be an error since the key `John` is duplicated
    // and `isSafeReplace()` function returns an error for the name `John`.
    map<int>|error studentScores = map from var {name, score} in students
                                   select [name, score]
                                   on conflict isSafeReplace(name);

    io:println(studentScores);

    // The result of the following will be an error since the key `1` is duplicated
    // and `isSafeReplace()` function returns an error for the name `John`.
    table<Student> key(id)|error studentScoresTable = table key(id) from var student in students
                                                      select student
                                                      on conflict isSafeReplace(student.name);

    io:println(studentScoresTable);

    table<Student> students2 = table [
            {id: 1, name: "John", score: 100},
            {id: 2, name: "Mike", score: 150},
            {id: 2, name: "Mike", score: 200}
        ];

    // The value `100` of the key `Mike` will be replaced by the second occurrence value `200`
    // since `isSafeReplace()` function returns `null` for the name 'Mike`.
    map<int>|error lastRoundScore = map from var student in students2
                                    select [student.name, student.score]
                                    on conflict isSafeReplace(student.name);

    io:println(lastRoundScore);

    // The return value will be just the construct type if the `on conflict` clause
    // always returns `()`.
    map<int> lastRoundScore2 = map from var student in students2
                               select [student.name, student.score]
                               on conflict ();

    io:println(lastRoundScore2);
}

function isSafeReplace(string name) returns error? {
    if name == "John" {
        return error("Key Conflict", message = "record with same key exists.");
    }
}
