import ballerina/io;

type Time [int, decimal];

// This function accepts a variable of the `Time` type and converts it to seconds in `decimal`.
function toSeconds(Time time) returns decimal {
    // The tuple value is destructured into two variables: `day` and `seconds`.
    var [day, seconds] = time;
    return 86400 * <decimal>day + seconds;
}

public function main() {
    Time time = [1, 12];
    decimal totalSeconds = toSeconds(time);
    io:println(totalSeconds);

    Time[] timeArray = [[1, 9.2], [2, 7.1]];

    // Each tuple value in the `timeArray` is destructured into two 
    // variables: `day` and `seconds`.
    foreach var [day, seconds] in timeArray {
        io:println(`day: ${day} seconds: ${seconds}`);
    }
}
