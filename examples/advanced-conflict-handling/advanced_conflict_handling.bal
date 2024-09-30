import ballerina/io;

type Student record {|
    string name;
    int score;
|};

public function main() {
    Student[] students = [
        {name: "John", score: 100},
        {name: "Jane", score: 150},
        {name: "John", score: 200}
    ];

    // Create a map of the student `name` and the `score` where we replace the value of the duplicate key if the new `score` is even.
    // The old `score` `100` of `John` will be replaced by the new `score` 200` since `replaceIfSafe()`returns `nil` for even scores.
    map<int>|error studentScores = map from var {name, score} in students
                                   select [name, score]
                                   on conflict replaceIfSafe(score);
    io:println(studentScores);

    students = [
        {name: "John", score: 100},
        {name: "Jane", score: 150},
        {name: "John", score: 211}
    ];

    // The result of this will be an error since the key `John` is duplicated and the `replaceIfSafe()`returns an error for odd `score` `211`.
    map<int>|error studentScores2 = map from var {name, score} in students
                                    select [name, score]
                                    on conflict replaceIfSafe(score);
    io:println(studentScores2);
}

function replaceIfSafe(int score) returns error? {
    if score % 2 != 0 {
        return error("Key Conflict", message = "Duplicate key has an odd score");
    }
}

