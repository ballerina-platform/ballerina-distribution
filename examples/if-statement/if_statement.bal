import ballerina/io;

function getGrades(int score) {
    // Parentheses are optional in conditions
    // but curly braces are required in `if/else` statements.
    if 75 < score && score < 100 {
        io:println("Grade: A");
    } else if 65 <= score {
        io:println("Grade: B");
    } else if 55 <= score {
        io:println("Grade: C");
    } else {
        io:println("Grade: F");
    }

}

public function main() {
    int score = 66;
    getGrades(score);

    int|string newScore = 77;

    // if statement can be used to type narrowing.
    if newScore is int {
        getGrades(newScore);
    }

}
