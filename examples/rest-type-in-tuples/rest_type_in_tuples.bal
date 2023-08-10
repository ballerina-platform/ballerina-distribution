import ballerina/io;

public function main() {
    // declare a tuple with zero or more `int` members after the first member of type `string`.
    [string, int...] scoreList = ["John", 55, 43, 65, 65];
    io:println(scoreList);

    [string, int...] secondScoreList = ["Amy"];
    io:println(secondScoreList);

    // [T...] is equivalent to array T[].
    [int...] scores = [];
    io:println(scores);

    scores = [23, 53];
    io:println(scores);

    // New members can be pushed to a tuple with rest type by using `array:push()` method
    scores.push(43);
    io:println(scores);
}
