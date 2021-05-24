import ballerina/io;
import ballerina/time;

public function main() returns error? {
    // Converts a given RFC 3339 timestamp(e.g. `2007-12-03T10:15:30.00Z`)
    // to a `time:Civil` record.
    time:Civil civil = check
    time:civilFromString("2021-04-12T23:20:50.520+05:30[Asia/Colombo]");
    io:println("Converted civil value: " + civil.toString());

    // Converts a given `time:Civil` value to a RFC 3339
    // (e.g. `2007-12-03T10:15:30.00Z`) formatted string.
    string civilString = check time:civilToString(civil);
    io:println(`Civil string representation: ${civilString}`);
}
