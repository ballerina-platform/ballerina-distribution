import ballerina/io;

function getGrades(int score) returns string {
    // Parentheses are optional in conditions.
    // Howevr, curly braces are required in `if/else` statements.
    if 0 < score && score < 55 {
        return "F";
    } else if 55 <= score && score < 65 {
        return "C";
    } else if 65 <= score && score < 75  {
        return "B";
    } else if 75 <= score && score <= 100 {
        return "A";
    } else {
        return "invalid grade";
    }
}

public function main() {
    int score = 66;
    string grade = getGrades(score);
    io:println(grade);

    int|string newScore = 77;

    // The `if` statement can be used for type narrowing.
    if newScore is int {
        io:println(getGrades(newScore));
    } else {
        io:println("score is not an integer");
    }

}
